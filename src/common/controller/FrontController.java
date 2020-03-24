package common.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FrontController
 */
@WebServlet(
		description = "사용자가 웹어서 *.up을 했을 경우 이 서블릿이 먼저 응답해주도록 한다.", 
		urlPatterns = { "*.army" }, 
		initParams = { 
				@WebInitParam(name = "propertyConfig", value = "C:/myjsp/SemiProject/WebContent/WEB-INF/command.properties", description = "*.army에 대한 클래스의 매핑파일")
		})
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	HashMap<String, Object> cmdMap = new HashMap<String, Object>();
	
	/*
	 	웹 브라우저 주소창에서 *.up을 하면 FrontController 서블릿이 응대하는데
	 	맨 처음에 자동적으로 실행되어지는 메소드가 init(ServletCnfig config)이다.
	 	여기서 중요한 것은 init(ServletCnfig config) 메소드는 WAS(톰캣)가 구동되어진 후
	 	딱 1번만 init(ServletCnfig config) 메소드가 실행되어지고, 그 이후에는 실행되지 않는다.
	*/
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		
		//확인용
		System.out.println("~~ 확인용 => 서블릿 FrontController의 init(ServletConfig config) 메소드가 실행됨");
		
		// Properties 는 Collection 중 HashMap 계열중의  하나로써
		// "key","value"으로 이루어져 있는것이다.
		// 그런데 중요한 것은 Properties 는 key도 String 타입이고, value도 String 타입만 가능하다는 것이다.
		// key는 중복을 허락하지 않는다. value 값을 얻어오기 위해서는 key값만 알면 된다.
		Properties pr = new Properties();
		
		//특정 파일에 내용을 읽어오기 위한 용도로 쓰이는 객체
		FileInputStream fis = null;
		
		try {
			//fis = new FileInputStream("C:/myjsp/MyMVC/WebContent/WEB-INF/command.properties");
			//또는
			String props = config.getInitParameter("propertyConfig");
			//"C:/myjsp/MyMVC/WebContent/WEB-INF/command.properties" 파일의 내용을 읽어오기 위한 용도로 쓰이는 객체를 생성함
			fis = new FileInputStream(props);
			//System.out.println(">> 확인용 props: " + props);
			//>> 확인용 props: C:/myjsp/MyMVC/WebContent/WEB-INF/command.properties
			
			/*
			 	fis 객체를 통해 "C:/myjsp/MyMVC/WebContent/WEB-INF/command.properties" 파일의 내용을 읽어다가
			 	properties 클래스의 객체 인 pr에 로드시킨다.
			 	pr은 읽어온 파일(command.properties)의 내용에서 = 을 기준으로 왼쪽은 key로 보고 오른쪽은 value로 인식한다.
			*/
			pr.load(fis);
			
			//확인용 -----------------------------
			
			/*
			 * String str_ClassName = pr.getProperty("/index.up");
			 * System.out.println("확인용 key 가 /index.up 인 value: " + str_ClassName);
			 * 
			 * str_ClassName = pr.getProperty("/member/memberRegister.up");
			 * System.out.println("확인용 key 가 /member/memberRegister.up 인 value: " +
			 * str_ClassName);
			 */
			
			//--------------------------------
			
			/*
			 	pr.keys();은
			 	C:/myjsp/MyMVC/WebContent/WEB-INF/command.properties 파일의 내용에서 
			 	= 을 기준으로 왼쪽에 있는 모든 key 들만 가져오는 것이다.
			*/
			Enumeration<Object> en = pr.keys();
			
			while( en.hasMoreElements() ) {
				
				String key_url = (String)en.nextElement();
				//System.out.println(key_url);
				System.out.println("확인용 클래스 이름: " + pr.getProperty(key_url));
				
				
				String className = pr.getProperty(key_url);
				if(className != null) {
					className = className.trim();
					
					//Stirng 타입으로 되어진 className을 클래스화 시켜주는 것이다.
					//주의할 점은 실제로 String 으로 되어져 있는 문자열이 클래스로 존재해야만 한다는 것이다.
					Class<?> cls = Class.forName(className);
					
					//클래스로 부터 실제 객체(인스턴스)를 생성해주는 것이다.
					Object obj = cls.newInstance();
					
					//cmdMap에서 Key값으로 command.properties 파일에 저장되어진 url을 주면 
					//cmdMap에서 해당 클래스에 대한 객체(인스턴스)를 얻어오도록 만든 것이다.
					cmdMap.put(key_url, obj);
				}
				
			}
			
		} catch (ClassNotFoundException e) {
			System.out.println(">>문자열로 명명되어진 클래스가 존재하지 않습니다.");
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println(">> C:/myjsp/SemiProject/WebContent/WEB-INF/command.properties 파일이 존재하지 않습니다.");
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		
		
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		requestProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		requestProcess(request, response);
	}
	
	private void requestProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//웹 브라우저 상의 주소 입력창에서 http://localhost:9090/MyMVC/member.idDuplicateCheck.up?userid=leess
		//와 같이 입력되었더라면
		//String url = request.getRequestURL().toString();
		//System.out.println("확인용 URL: " + url);
		//확인용 URL: http://localhost:9090/MyMVC/member/memberRegister.up
		
		String uri = request.getRequestURI();
		//System.out.println("확인용 URI: " + uri);
		
		String ctxPath = request.getContextPath();
		//System.out.println("ctxPaht: "+ctxPath);
		
		String mapKey = uri.substring(ctxPath.length());
		//System.out.println("확인용 mapKey: " + mapKey);
		
		AbstractController action = (AbstractController) cmdMap.get(mapKey);
		
		if(action == null) {
			System.out.println(">>"+ mapKey + " URL 패턴에 매칭된 클래스는 없습니다.");
		}
		else {
			
			try {
				action.execute(request, response);
				
				boolean bool = action.isRedirect();
				
				String viewPage = action.getViewPage();
				
				if(!bool) {
					//viewPage에 명기된 view단 페이지로 forward(dispatcher)를 하겠다는 말이다.
					RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
					dispatcher.forward(request, response);
				}
				else {
					//View Page에 명기된 주소로 sendRedirect를 하겠단 말이다.
					response.sendRedirect(viewPage);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
	}

}
