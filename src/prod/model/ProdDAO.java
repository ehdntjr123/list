package prod.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.Cookie;
import javax.sql.DataSource;

public class ProdDAO implements InterProdDAO {

	private DataSource ds;

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public ProdDAO() {

		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/semi");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	public void close() {
		try {
			if (rs != null) {
				rs.close();
				rs = null;
			}
			if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			if (conn != null) {
				conn.close();
				conn = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 카테고리 목록 \\
	@Override
	public List<HashMap<String, String>> getCategoryList() throws SQLException {
		List<HashMap<String, String>> categoryList = null;

		try {

			conn = ds.getConnection();

			String sql = "select pcategoryno, gendercode, materialcode, pcategoryname from tbl_semi_productcategory order by pcategoryno asc";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			int cnt = 0;
			while (rs.next()) {
				cnt++;

				if (cnt == 1) {
					categoryList = new ArrayList<HashMap<String, String>>();
				}

				HashMap<String, String> map = new HashMap<String, String>();
				map.put("pcategoryno", rs.getString("pcategoryno"));
				map.put("gendercode", rs.getString("gendercode"));
				map.put("materialcode", rs.getString("materialcode"));
				map.put("pcategoryname", rs.getString("pcategoryname"));

				categoryList.add(map);
			}

		} finally {
			close();
		}

		return categoryList;
	}

	// 상품 상세 \\
	@Override
	public ProdVO showProdInfo(String productno_) throws SQLException {
		ProdVO product = null;

		try {

			conn = ds.getConnection();

			String sql = "select productno, productname, brand, pimage, price, pstock, fk_pcategoryno, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate\n"
					+ "from tbl_semi_product\n" + "where productno = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productno_);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				int productno = rs.getInt("productno");
				String productname = rs.getString("productname");
				String brand = rs.getString("brand");
				String pimage = rs.getString("pimage");
				int price = rs.getInt("price");
				int pstock = rs.getInt("pstock");
				int fk_pcategoryno = rs.getInt("fk_pcategoryno");
				String pinputdate = rs.getString("pinputdate");

				product = new ProdVO(productno, productname, brand, pimage, price, pstock, fk_pcategoryno, pinputdate);

			}

		} finally {
			close();
		}

		return product;
	}

	// 상품 상세 이미지 \\
	@Override
	public List<ProdImgVO> showProdInfoImg(String productno_) throws SQLException {
		List<ProdImgVO> prodImgList = null;

		try {

			conn = ds.getConnection();

			String sql = " select imageno, imagefilename, fk_productmo " + " from tbl_semi_productimages "
					+ " where fk_productmo = ? " + " order by imageno ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productno_);

			rs = pstmt.executeQuery();

			int cnt = 0;
			while (rs.next()) {
				cnt++;

				if (cnt == 1) {
					prodImgList = new ArrayList<ProdImgVO>();
				}

				ProdImgVO prodImg = new ProdImgVO();
				prodImg.setImageno(rs.getInt("imageno"));
				prodImg.setImagfilename(rs.getString("imagefilename"));
				prodImg.setFk_productmo(rs.getInt("fk_productmo"));

				prodImgList.add(prodImg);
			}

		} finally {
			close();
		}

		return prodImgList;
	}

	// 상품 리뷰 \\ 
	@Override
	public List<ReviewVO> showReview(String productno_) throws SQLException { 
		
		List<ReviewVO> reviewList = null;
	 
		try {
			
			conn = ds.getConnection();
			
			String sql = " select reviewno, fk_userno, substr(fk_userid,1,3)||lpad('*',length(fk_userid)-3,'*') as fk_userid, to_char(reviewwriteday, 'yyyy-mm-dd') as reviewwriteday, reviewtitle, reviewcontent, score \n"
					   + " from tbl_semi_review \n"
					   + " where fk_productno = ? ";
	  
			pstmt = conn.prepareStatement(sql); pstmt.setString(1, productno_);
			rs = pstmt.executeQuery();
	  
			int cnt = 0;
	  
			while(rs.next()) { 
				
				cnt++;
				if(cnt==1) { 
					reviewList = new ArrayList<ReviewVO>();
				}
	  
				ReviewVO rvo = new ReviewVO();
	  
				rvo.setReviewno(rs.getInt("reviewno"));
				rvo.setFk_userno(rs.getInt("fk_userno"));
				rvo.setFk_userid(rs.getString("fk_userid"));
				rvo.setReviewwriteday(rs.getString("reviewwriteday"));
				rvo.setReviewtitle(rs.getString("reviewtitle"));
				rvo.setReviewcontent(rs.getString("reviewcontent"));
				rvo.setScore(rs.getInt("score"));
	  
				reviewList.add(rvo);
			}
	  
	  } finally {
		  close(); 
	  }  
	  return reviewList;
	}

	// 장바구니 개수 가져오기 \\
	@Override
	public int cartCount(String userid, String user_ip) throws SQLException {
		int cnt = 0;

		try {

			conn = ds.getConnection();

			String sql = "";

			if (userid != null) {
				sql = " select count(*) as cnt \n " + " from tbl_semi_cart \n " + " where fk_userid = ?";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);

			} else {
				sql = "select count(*) as cnt \n" + "from tbl_semi_cart \n"
						+ "where fk_userid is null and user_ip = ? ";

				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, user_ip);
			}

			rs = pstmt.executeQuery();

			rs.next();

			cnt = rs.getInt("cnt");

		} finally {
			close();
		}

		return cnt;

	}

	// 장바구니 중복 체크 \\
	@Override
	public boolean checkDuplication(String userid, String productno_) throws SQLException {
		boolean checkDuplication = false;

		try {

			conn = ds.getConnection();

			String sql = "";

			if (userid != null) {

				sql = "select * \n" + "from tbl_semi_cart \n" + "where fk_userid = ? and fk_productno = ?";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, productno_);

			} else {
				sql = "select * \n" + "from tbl_semi_cart \n" + "where fk_userid is null and fk_productno = ?";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, productno_);
			}

			rs = pstmt.executeQuery();

			checkDuplication = rs.next();

		} finally {
			close();
		}

		return checkDuplication;
	}

	// 장바구니로 보내기 \\
	@Override
	public int inputCart(String productno_, String userid, String user_ip) throws SQLException {
		int n = 0;

		try {

			conn = ds.getConnection();

			String sql = "insert into tbl_semi_cart(cartno, cartregisterday, cartordercount, fK_productno, fk_userid, user_ip)\n"
					+ "values(seq_semi_cart.nextval, default, 1, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, productno_);
			pstmt.setString(2, userid);
			pstmt.setString(3, user_ip);

			n = pstmt.executeUpdate();

		} finally {
			close();
		}

		return n;
	}

	// 장바구니 수량 증가 \\
	@Override
	public int plusOrderCount(String productno_, String userid) throws SQLException {
		int result = 0;

		try {

			conn = ds.getConnection();

			String sql = "";

			if (userid != null) {

				sql = "update tbl_semi_cart set cartordercount = cartordercount+1 where fk_userid = ? and fk_productno = ?";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, productno_);

			} else {

				sql = "update tbl_semi_cart set cartordercount = cartordercount+1 where fk_userid is null and fk_productno = ?";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, productno_);
			}

			result = pstmt.executeUpdate();

		} finally {
			close();
		}

		return result;
	}

	// 장바구니 제품번호 알아오기 \\
	@Override
	public List<String> getCartList(String userid, String user_ip) throws SQLException {
		List<String> productnoList = null;

		try {

			conn = ds.getConnection();

			String sql = "";
			if (userid != null) {
				sql = " select fk_productno " + " from tbl_semi_cart " + " where fk_userid = ? ";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
			}

			else {
				sql = " select fk_productno " + " from tbl_semi_cart " + " where fk_userid is null and user_ip = ?";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user_ip);
			}

			rs = pstmt.executeQuery();

			int cnt = 0;
			while (rs.next()) {
				cnt++;
				if (cnt == 1) {
					productnoList = new ArrayList<String>();
				}

				String productno = rs.getString("fk_productno");

				productnoList.add(productno);
			}

		} finally {
			close();
		}

		return productnoList;
	}

	// 장바구니 목록 가져오기 \\
	@Override
	public List<ProdVO> showCartList(List<String> cartProdNo, String userid, String user_ip) throws SQLException {
		List<ProdVO> cartList = null;
		cartList = new ArrayList<ProdVO>();
		try {

			conn = ds.getConnection();

			String sql = "";
			String prodNo = "";

			for (int i = 0; i < cartProdNo.size(); i++) {
				prodNo = cartProdNo.get(i);

				sql = "select productno, productname, brand, pimage, price, pstock, fk_pcategoryno, pinputdate, cartordercount, fk_userid, user_ip\n"
						+ "from\n" + "(\n"
						+ "select P.productno as productno, P.productname as productname, P.brand as brand, P.pimage as pimage, P.price as price, P.pstock as pstock, P.fk_pcategoryno as fk_pcategoryno, to_char(P.pinputdate, 'yyyy-mm-dd') as pinputdate, C.cartordercount as cartordercount, C.fk_userid as fk_userid, C.user_ip as user_ip\n"
						+ "from tbl_semi_product P , tbl_semi_cart C\n" + "where productno = fk_productno\n" + ") V\n";

				if (userid != null) {
					sql += "where productno = ? and fk_userid = ? ";

					pstmt = conn.prepareStatement(sql);

					pstmt.setString(1, prodNo);
					pstmt.setString(2, userid);
				} else {
					sql += " where productno = ? and fk_userid is null " + " and user_ip = ?";

					pstmt = conn.prepareStatement(sql);

					pstmt.setString(1, prodNo);
					pstmt.setString(2, user_ip);
				}

				rs = pstmt.executeQuery();

				if (rs.next()) {

					ProdVO pvo = new ProdVO();

					pvo.setProductno(rs.getInt("productno"));
					pvo.setProductname(rs.getString("productname"));
					pvo.setBrand(rs.getString("brand"));
					pvo.setPimage(rs.getString("pimage"));
					pvo.setPrice(rs.getInt("price"));
					pvo.setPstock(rs.getInt("pstock"));
					pvo.setFk_pcategoryno(rs.getInt("fk_pcategoryno"));
					pvo.setPinputdate(rs.getString("pinputdate"));
					pvo.setCartordercount(rs.getInt("cartordercount"));
					pvo.setFk_userid(rs.getString("fk_userid"));
					cartList.add(pvo);

				}

			}

		} finally {
			close();
		}

		return cartList;
	}

	// 장바구니 합계 \\
	@Override
	public int getCartSum(List<String> cartProdNo, String userid, String user_ip) throws SQLException {
		int sum = 0;

		try {

			conn = ds.getConnection();

			String sql = "";
			String prodNo = "";

			for (int i = 0; i < cartProdNo.size(); i++) {
				prodNo = cartProdNo.get(i);

				sql = "select price*cartordercount as sum\n" + "from\n" + "(\n"
						+ "select P.productno as productno, P.price as price, C.cartordercount as cartordercount, C.fk_userid as fk_userid, C.user_ip as user_ip\n"
						+ "from tbl_semi_product P , tbl_semi_cart C\n" + "where productno = fk_productno\n" + ") V\n";

				if (userid != null) {
					sql += "where productno = ? and fk_userid = ?";

					pstmt = conn.prepareStatement(sql);

					pstmt.setString(1, prodNo);
					pstmt.setString(2, userid);
				} else {
					sql += "where productno = ? and fk_userid is null and user_ip = ?";

					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, prodNo);
					pstmt.setString(2, user_ip);
				}

				rs = pstmt.executeQuery();

				if (rs.next()) {
					sum += rs.getInt("sum");
				}

			}
		} finally {
			close();
		}

		return sum;
	}

	// 장바구니 삭제 \\
	@Override
	public int deleteCart(String productno, String userid, String user_ip) throws SQLException {
		int result = 0;

		try {

			conn = ds.getConnection();

			String sql = "";

			sql = "delete from tbl_semi_cart \n";

			if (userid != null) {
				sql += "where fk_productno = ? and fk_userid = ?";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, productno);
				pstmt.setString(2, userid);
			}
			else {
				sql += "where fk_productno = ? and fk_userid is null and user_ip = ?";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, productno);
				pstmt.setString(2, user_ip);
			}

			result = pstmt.executeUpdate();

		} finally {
			close();
		}

		return result;
	}

	// 장바구니 갯수 감소
	@Override
	public int MinusOrderCount(String productno_, String userid) throws SQLException {

		int result = 0;

		try {

			conn = ds.getConnection();

			String sql = "";

			if (userid != null) {

				sql = "update tbl_semi_cart set cartordercount = cartordercount-1 where fk_userid = ? and fk_productno = ?";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, productno_);

			} else {

				sql = "update tbl_semi_cart set cartordercount = cartordercount-1 where fk_userid is null and fk_productno = ?";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, productno_);
			}

			result = pstmt.executeUpdate();

		} finally {
			close();
		}

		return result;
	}

	// 상품 목록 갯수 가져오기 \\
	@Override
	public int getTotalCount(HashMap<String, String> paraMap) throws SQLException {
		int totalCount = 0;

		try {

			conn = ds.getConnection();

			String sql = "";

			// 카테고리 선택 \\
			if (paraMap.get("search") == null && paraMap.get("code") != null) {
				sql = "select count(*) as cnt\n" + "from tbl_semi_product \n";

				if ("1".equals(paraMap.get("code"))) {
					sql += "where fk_pcategoryno in (1,2)";
				} else if ("2".equals(paraMap.get("code"))) {
					sql += "where fk_pcategoryno in (3,4)";
				} else if ("3".equals(paraMap.get("code"))) {
					sql += "where fk_pcategoryno in (1,3)";
				} else if ("4".equals(paraMap.get("code"))) {
					sql += "where fk_pcategoryno in (2,4)";
				}

				pstmt = conn.prepareStatement(sql);

			}

			// 검색 \\
			else if (paraMap.get("search") != null && paraMap.get("code") == null) {
				sql = "select count(*) as cnt\n" + "from tbl_semi_product \n";

				if ("1".equals(paraMap.get("code"))) {
					sql += "where UPPER(productname) like UPPER('%'|| ? ||'%') ";
				} else if ("2".equals(paraMap.get("code"))) {
					sql += "where UPPER(productname) like UPPER('%'|| ? ||'%')";
				} else if ("3".equals(paraMap.get("code"))) {
					sql += "where UPPER(productname) like UPPER('%'|| ? ||'%')";
				} else if ("4".equals(paraMap.get("code"))) {
					sql += "where UPPER(productname) like UPPER('%'|| ? ||'%')";
				}

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("search"));
			}

			// 선택과 검색 (따로 들어가는 버튼은 없지만, 주소창에 장난 칠 경우) \\
			else if (paraMap.get("search") != null && paraMap.get("code") != null) {
				sql = "select count(*) as cnt\n" + "from tbl_semi_product \n";

				if ("1".equals(paraMap.get("code"))) {
					sql += "where fk_pcategoryno in (1,2) and UPPER(productname) like UPPER('%'|| ? ||'%') ";
				} else if ("2".equals(paraMap.get("code"))) {
					sql += "where fk_pcategoryno in (3,4) and UPPER(productname) like UPPER('%'|| ? ||'%')";
				} else if ("3".equals(paraMap.get("code"))) {
					sql += "where fk_pcategoryno in (1,3) and UPPER(productname) like UPPER('%'|| ? ||'%')";
				} else if ("4".equals(paraMap.get("code"))) {
					sql += "where fk_pcategoryno in (2,4) and UPPER(productname) like UPPER('%'|| ? ||'%')";
				}

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("search"));
			}

			rs = pstmt.executeQuery();

			rs.next();

			totalCount = rs.getInt("cnt");

		} finally {
			close();
		}

		return totalCount;
	}

	// 상품 목록 가져오기 \\
	@Override
	public List<ProdVO> getProdList(HashMap<String, String> paraMap) throws SQLException {
		List<ProdVO> prodList = null;

		String gendercode = "";
		String materialcode = "";

		if ("1".equals(paraMap.get("code"))) {
			gendercode = "1";
			materialcode = "2";
		} else if ("2".equals(paraMap.get("code"))) {
			gendercode = "3";
			materialcode = "4";
		} else if ("3".equals(paraMap.get("code"))) {
			gendercode = "1";
			materialcode = "3";
		} else if ("4".equals(paraMap.get("code"))) {
			gendercode = "2";
			materialcode = "4";
		}

		try {

			conn = ds.getConnection();
			String sql = "";

			sql += "select rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, pinputdate \n"
					+ "from \n" + "( \n";

			// 카테고리 선택 \\
			if (paraMap.get("search") == null && paraMap.get("sort") == null) {

				sql += "select row_number() over(order by productno) as rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate \n"
						+ "from tbl_semi_product \n" + "where fk_pcategoryno in (?,?) \n" + ") V \n"
						+ "where rno between ? and ?";

				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, gendercode);
				pstmt.setString(2, materialcode);
				pstmt.setString(3, paraMap.get("start"));
				pstmt.setString(4, paraMap.get("end"));

			}

			// 카테고리 선택 후 정렬 \\
			else if (paraMap.get("search") == null && paraMap.get("sort") != null) {

				if ("1".equals(paraMap.get("sort"))) {
					sql += "select row_number() over(order by pinputdate desc) as rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate \n";
				} else if ("2".equals(paraMap.get("sort"))) {
					sql += "select row_number() over(order by pstock) as rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate \n";
				} else if ("3".equals(paraMap.get("sort"))) {
					sql += "select row_number() over(order by price) as rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate \n";
				} else if ("4".equals(paraMap.get("sort"))) {
					sql += "select row_number() over(order by price desc) as rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate \n";
				} else {
					sql += "select row_number() over(order by productno) as rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate \n";
				}

				sql += "from tbl_semi_product \n" + "where fk_pcategoryno in (?,?) \n" + ") V \n"
						+ "where rno between ? and ?";

				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, gendercode);
				pstmt.setString(2, materialcode);
				pstmt.setString(3, paraMap.get("start"));
				pstmt.setString(4, paraMap.get("end"));
			}

			// 검색 \\
			else if (paraMap.get("search") != null && paraMap.get("sort") == null) {

				sql += "select row_number() over(order by productno) as rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate \n"
						+ "from tbl_semi_product \n"
						+ "where fk_pcategoryno in (?,?) and productname like UPPER('%'|| ? ||'%') \n" + ") V \n"
						+ "where rno between ? and ?";

				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, gendercode);
				pstmt.setString(2, materialcode);
				pstmt.setString(3, paraMap.get("search"));
				pstmt.setString(4, paraMap.get("start"));
				pstmt.setString(5, paraMap.get("end"));
			}

			// 검색 후 정렬 \\
			else if (paraMap.get("search") != null && paraMap.get("sort") != null) {

				if ("1".equals(paraMap.get("sort"))) {
					sql += "select row_number() over(order by pinputdate desc) as rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate \n";
				} else if ("2".equals(paraMap.get("sort"))) {
					sql += "select row_number() over(order by pstock) as rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate \n";
				} else if ("3".equals(paraMap.get("sort"))) {
					sql += "select row_number() over(order by price) as rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate \n";
				} else if ("4".equals(paraMap.get("sort"))) {
					sql += "select row_number() over(order by price desc) as rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate \n";
				} else {
					sql += "select row_number() over(order by productno) as rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate \n";
				}

				sql += "from tbl_semi_product \n"
						+ "where fk_pcategoryno in (?,?) and UPPER(productname) like UPPER('%'|| ? ||'%') \n" + ") V \n"
						+ "where rno between ? and ?";

				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, gendercode);
				pstmt.setString(2, materialcode);
				pstmt.setString(3, paraMap.get("search"));
				pstmt.setString(4, paraMap.get("start"));
				pstmt.setString(5, paraMap.get("end"));

			}

			rs = pstmt.executeQuery();

			int cnt = 0;

			while (rs.next()) {
				cnt++;

				if (cnt == 1) {
					prodList = new ArrayList<ProdVO>();
				}

				ProdVO pvo = new ProdVO();

				pvo.setProductno(rs.getInt("productno"));
				pvo.setProductname(rs.getString("productname"));
				pvo.setBrand(rs.getString("brand"));
				pvo.setPimage(rs.getString("pimage"));
				pvo.setPrice(rs.getInt("price"));
				pvo.setPstock(rs.getInt("pstock"));
				pvo.setFk_pcategoryno(rs.getInt("fk_pcategoryno"));
				pvo.setPinputdate(rs.getString("pinputdate"));

				prodList.add(pvo);

			}

		} finally {
			close();
		}

		return prodList;
	}

	// 메인에서 남자 여자 가격순으로 4개 보여주기
	@Override
	public List<ProdVO> showMainView() throws SQLException {
		List<ProdVO> product2 = null;

		try {

			conn = ds.getConnection();

			String sql = "select rownum, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, pinputdate\n"
					+ "from\n" + "(\n"
					+ "select rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, pinputdate\n"
					+ "from\n" + "(\n"
					+ "select rownum as rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, pinputdate\n"
					+ "from\n" + "(\n"
					+ "select productno, productname, brand, pimage, price, pstock, fk_pcategoryno, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate\n"
					+ "from tbl_semi_product\n" + "where fk_pcategoryno in (1,2)\n" + "order by price desc\n" + ")V\n"
					+ ")T\n" + "where T.rno between 1 and 4\n" + "union all\n"
					+ "select rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, pinputdate\n"
					+ "from\n" + "(\n"
					+ "select rownum as rno, productno, productname, brand, pimage, price, pstock, fk_pcategoryno, pinputdate\n"
					+ "from\n" + "(\n"
					+ "select productno, productname, brand, pimage, price, pstock, fk_pcategoryno, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate\n"
					+ "from tbl_semi_product\n" + "where fk_pcategoryno in (3,4)\n" + "order by price desc\n" + ")V\n"
					+ ")T\n" + "where T.rno between 1 and 4\n" + ")W";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			int cnt = 0;
			while (rs.next()) {
				cnt++;
				if (cnt == 1) {
					product2 = new ArrayList<ProdVO>();
				}

				int productno2 = rs.getInt("productno");
				String productname2 = rs.getString("productname");
				String brand2 = rs.getString("brand");
				String pimage2 = rs.getString("pimage");
				int price2 = rs.getInt("price");
				int pstock2 = rs.getInt("pstock");
				int fk_pcategoryno2 = rs.getInt("fk_pcategoryno");
				String pinputdate2 = rs.getString("pinputdate");

				ProdVO main = new ProdVO(productno2, productname2, brand2, pimage2, price2, pstock2, fk_pcategoryno2,
						pinputdate2);

				product2.add(main);

			}
			//

		} finally {
			close();
		}

		return product2;
	}

	// 위시 리스트 \\
	@Override
	public boolean checkWishDuplication(String userno, String productno_) throws SQLException {
		boolean bool = false;

		try {

			conn = ds.getConnection();

			String sql = "insert into tbl_semi_wishlist(wishlistno, wregisterday, fk_productno, fk_userno)\n"
					+ "values(seq_semi_wishlist.nextval, default, ?, ?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productno_);
			pstmt.setString(2, userno);

			int n = pstmt.executeUpdate();

			if (n <= 1) {
				bool = true;
			} else {
				bool = false;
			}

		} finally {
			close();
		}

		return bool;

	}

	// 유저 번호 채번 \\
	@Override
	public String getUserno(String userid) throws SQLException {
		String userno = null;

		try {

			conn = ds.getConnection();

			String sql = "select userno\n" + "from tbl_semi_member\n" + "where userid = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				userno = rs.getString("userno");
			}

		} finally {
			close();
		}

		return userno;
	}

	// 리뷰 작성하려는 상품 정보 \\
	@Override
	public ProdVO showOrderProduct(String productname) throws SQLException {
		ProdVO product = null;

		try {

			conn = ds.getConnection();

			String sql = "select productno, pimage, productname from tbl_semi_product where productname = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, productname);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				product = new ProdVO();

				product.setProductno(rs.getInt("productno"));
				product.setProductname(rs.getString("productname"));
				product.setPimage(rs.getString("pimage"));

			}

		} finally {
			close();
		}

		return product;
	}

	// 리뷰 작성 \\
	@Override
	public int writeReview(HashMap<String, String> map) throws SQLException {
		int result = 0;

		try {

			conn = ds.getConnection();

			String sql = "insert into tbl_semi_review(reviewno, fk_userno, fk_productno, reviewwriteday, reviewtitle, reviewcontent, fk_userid, score)\n"
					+ "values(seq_semi_review.nextval, ?, ?, default, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, map.get("userno"));
			pstmt.setString(2, map.get("productno"));
			pstmt.setString(3, map.get("contents"));
			pstmt.setString(4, map.get("contents"));
			pstmt.setString(5, map.get("userid"));
			pstmt.setString(6, map.get("score"));

			result = pstmt.executeUpdate();

		} finally {
			close();
		}

		return result;
	}

	// 제품번호 조회
	@Override
	public String getProdNo(String productname) throws SQLException {
		String prodno = null;

		try {

			conn = ds.getConnection();

			String sql = "select productno\n" + "from tbl_semi_product\n" + "where productname = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productname);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				prodno = rs.getString("productno");
			}

		} finally {
			close();
		}

		return prodno;
	}

	// 리뷰 중복확인
	@Override
	public List<String> checkReview(String userid, List<String> productnoList) throws SQLException {
		List<String> cnt = null;

		cnt = new ArrayList<String>();

		try {
			conn = ds.getConnection();

			String sql = "";

			for (int i = 0; i < productnoList.size(); i++) {

				sql = "select * from tbl_semi_review where fk_userid = ? and fk_productno = ?";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, productnoList.get(i));

				rs = pstmt.executeQuery();

				int n = 0;
				
				if (rs.next()) {
					n = 1;
					cnt.add(String.valueOf(n));
				} else {
					n = 0;
					cnt.add(String.valueOf(n));
				}

			}

		} finally {
			close();
		}

		return cnt;
	}

	// 리뷰 수정 \\
	@Override
	public int editReview(HashMap<String, String> map) throws SQLException {
		int result = 0;

		try {

			conn = ds.getConnection();

			String sql = "update tbl_semi_review set reviewtitle = ?, reviewcontent = ?, score = ?, reviewwriteday = sysdate \n"
					+ "where fk_productno = ? and fk_userno = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, map.get("contents"));
			pstmt.setString(2, map.get("contents"));
			pstmt.setString(3, map.get("score"));
			pstmt.setString(4, map.get("productno"));
			pstmt.setString(5, map.get("userno"));

			result = pstmt.executeUpdate();

		} finally {
			close();
		}

		return result;

	}

	// 리뷰 삭제 \\
	@Override
	public int deleteReview(HashMap<String, String> map) throws SQLException {
		int result = 0;

		try {

			conn = ds.getConnection();

			String sql = "delete from tbl_semi_review where fk_userno = ? and fk_productno = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, map.get("userno"));
			pstmt.setString(2, map.get("productno"));

			result = pstmt.executeUpdate();

		} finally {
			close();
		}

		return result;
	}

	// 수정,삭제용 리뷰 조회 \\
	@Override
	public ReviewVO showReviewOne(String productno, String userid) throws SQLException {
		ReviewVO review = null;

		try {
			conn = ds.getConnection();

			String sql = "select reviewcontent, score from tbl_semi_review where fk_userid = ? and fk_productno = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, productno);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				review = new ReviewVO();

				review.setReviewcontent(rs.getString("reviewcontent"));
				review.setScore(rs.getInt("score"));
			}

		} finally {
			close();
		}

		return review;
	}

}
