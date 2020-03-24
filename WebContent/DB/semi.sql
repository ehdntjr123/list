-- 회원 테이블
create table tbl_semi_member
(
     userno         number not null         -- 회원번호(시퀀스로 데이터가 들어온다)
    ,userid         nvarchar2(20) not null  -- 회원아이디
    ,userpw         nvarchar2(200) not null -- 비밀번호 (SHA-256 암호화 대상)
    ,username       nvarchar2(20) not null  -- 회원명
    ,email          nvarchar2(200) not null -- 이메일   (AES-256 암호화/복호화 대상)
    ,phone          nvarchar2(200) not null -- 휴대폰   (AES-256 암호화/복호화 대상)   
    ,postno         nvarchar2(6)            -- 우편번호(기존 우편번호 6자리, 신규 우편번호 5자리)
    ,addr1          nvarchar2(100)          -- 주소
    ,addr2          nvarchar2(100)          -- 상세 주소
    ,status         number(1) default 1     -- 가입 상태 여부 1:가입 0:탈퇴
    ,registerday    date default sysdate    -- 가입일자
    ,lastlogindate  date default sysdate    -- 마지막 로그인 한 날짜
    ,pwchangedate   date default sysdate    -- 마지막 비밀번호 변경 날짜
    ,constraint     PK_tbl_semi_member_userno primary key(userno)
    ,constraint     UK_tbl_semi_member_userid unique(userid)
    ,constraint     CK_tbl_semi_member_status check( status in(0,1))
);

-- 회원 테이블 시퀀스
create sequence seq_semi_member
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 회원 탈퇴 테이블
create table tbl_semi_memberwithdrawal
(
     withdrawalno           number not null         -- 회원탈퇴 번호(시퀀스 사용)                             
    ,fk_userno              number                  -- 회원번호(외래키)
    ,withdrawalreason       nvarchar2(100)          -- 탈퇴 사유
    ,withdrawalcontent      clob                    -- 탈퇴 내용
    ,withdrawalday          date default sysdate    -- 탈퇴 날짜
    ,constraint             PK_tbl_semi_withdrawalno primary key(withdrawalno)
    ,constraint             FK_tbl_semi_withdrawal_userno foreign key(fk_userno)
                            references tbl_semi_member (userno)
);

-- 회원탈퇴 테이블 시퀀스
create sequence seq_semi_memberwithdrawal
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 공지사항 테이블
create table tbl_semi_notice
(
     noticeno           number          not null        -- 공지사항 글번호
    ,noticetile         nvarchar2(100)  not null        -- 공지사항 제목
    ,noticecontent      clob                            -- 공지사항 내용
    ,noticewriteday     date default sysdate            -- 공지사항 작성일자
    ,constraint         PK_tbl_semi_noticeno primary key(noticeno)
);

-- 공지사항 시퀀스
create sequence seq_semi_notice
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 자유게시판 테이블
create table tbl_semi_board
(
     boardno            number not null         -- 자유게시판 글번호
    ,fk_userno          number                  -- 회원번호(외래키)
    ,boardtitle         nvarchar2(100)          -- 자유게시판 글 제목
    ,boardcontent       clob                    -- 자유게시판 글 내용
    ,boardwriteday      date default sysdate    -- 자유게시판 작성 일자
    ,constraint         PK_tbl_semi_boardno primary key(boardno)
    ,constraint         FK_tbl_semi_board_userno foreign key(fk_userno)
                        references tbl_semi_member (userno)
);

-- 자유게시판 시퀀스
create sequence seq_semi_board
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 문의내역 테이블
create table tbl_semi_inquiry
(
    inquiryno           number not null         -- 문의내역 글번호         
    ,fk_userno          number                  -- 회원번호(외래키)
    ,inquirytitle       nvarchar2(100)          -- 문의내역 제목
    ,inquirycontent     clob                    -- 문의내역 내용
    ,inquiryday         date default sysdate    -- 문의 작성 일자
    ,inquirycoment      clob                    -- 답변 내용
    ,inquirycode        nvarchar2(20)           -- 문의 코드
    ,constraint         PK_tbl_semi_inquiryno primary key(inquiryno)
    ,constraint         FK_tbl_semi_inquiry_userno foreign key (fk_userno)
                        references tbl_semi_member(userno)
);

-- 문의내역 시퀀스
create sequence seq_semi_inquiry
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 리뷰 테이블
create table tbl_semi_review
(
     reviewno           number                  -- 리뷰 글번호
    ,fk_userno          number                  -- 회원번호(외래키)
    ,fk_productno       number                  -- 제품번호(외래키)
    ,reviewwriteday     date default sysdate    -- 리뷰 작성 일자
    ,reviewtitle        nvarchar2(100)          -- 리뷰 제목
    ,reviewcontent      clob                    -- 리뷰 내용
    ,constraint         PK_tbl_semi_reviewno primary key (reviewno)
    ,constraint         FK_tbl_semi_review_userno foreign key (fk_userno)
                        references tbl_semi_member (userno)
    ,constraint         FK_tlb_semi_review_productno foreign key(fk_productno)
                        references tbl_semi_product (productno)
);

-- 리뷰 시퀀스
create sequence seq_semi_review
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 제품 카테고리 테이블
create table tbl_semi_productcategory
(
    pcategoryno             number not null     -- 카테고리 번호
    ,gendercode             number(1) not null  -- 성별 구분 코드 1:남성시계 2:여성시계
    ,materialcode           number(1) not null  -- 소재 구분 코드 1:가죽시계 2:메탈시계
    ,pcategoryname          nvarchar2(20)       -- 카테고리명 ex) 남성가죽시계, 여성가죽시계
    ,constraint PK_tbl_semi_productcategoryno primary key (pcategoryno)
    ,constraint CK_tbl_semi_prodectgender check (gendercode in(1, 2))
    ,constraint CK_tbl_semi_prodectmaterial check (materialcode in(1, 2))
);

-- 제품 카테고리 시퀀스
create sequence seq_semi_productcategory
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 제품 이미지 테이블
create table tbl_semi_productimages
(
    imageno                 number not null             -- 제품 이미지 번호
    ,imagefilename          nvarchar2(100) not null     -- 제품 이미지 파일 이름
    ,fk_productmo           number                      -- 제품코드
    ,constraint             PK_tbl_semi_imageno primary key(imageno)
    ,constraint             UK_tbl_semi_imagefilename unique(imagefilename)
    ,constraint             FK_tbl_semi_images_productno foreign key (fk_productmo)
                            references tbl_semi_product (productno)
);

-- 제품 이미지 시퀀스
create sequence seq_semi_productimage
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 제품 테이블
create table tbl_semi_product
(
    productno               number not null                     -- 제품번호
    ,proeuctname            nvarchar2(100) not null             -- 제품이름
    ,brand                  nvarchar2(20)                       -- 제품 제조회사
    ,pimage                 varchar2(100) default 'noimage.png' -- 제품 대표이미지
    ,price                  number                              -- 제품 가격
    ,pstock                 number                              -- 제품 재고
    ,fk_pcategoryno         number                              -- 제품 카테고리번호(외래키)
    ,pinputdate             date default sysdate                -- 마지막 제품 입고일자
    ,constraint             PK_tbl_semi_poductno primary key (productno)
    ,constraint             FK_tbl_semi_pcategoryno foreign key (fk_pcategoryno)
                            references tbl_semi_productcategory (pcategoryno)
);

-- 제품 시퀀스
create sequence seq_semi_product
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-------------------------------------------------------------------------------------

-- 전표 테이블
create table tbl_semi_statement
(
     statementno            number                  -- 전표번호
    ,statementday           date default sysdate    -- 전표날짜
    ,constraint             PK_tbl_semi_statementno primary key (statementno)
);

-- 전표 시퀀스
create sequence seq_semi_statement
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 주문상세 테이블
create table tbl_semi_orderdetail
(
     orderno                number not null             -- 주문번호
    ,orderaddr1             nvarchar2(100) not null     -- 결제 주소    
    ,orderaddr2             nvarchar2(100) not null     -- 결제 상세 주소
    ,orderpostno            nvarchar2(6) not null       -- 결제 우편번호
    ,ordercount             number                      -- 주문 수량
    ,fk_cartno              number                      -- 장바구니번호(외래키)
    ,fk_productno           number                      -- 제품번호(외래키)
    ,fk_userno              number                      -- 회원번호(외래키)
    ,fk_statementno         number                      -- 전표번호(외래키)
    ,constraint             PK_tbl_semi_orderno primary key (orderno)
    ,constraint             FK_tbl_semi_orderdetail_cartno foreign key (fk_cartno)
                            references tbl_semi_cart (cartno)
    ,constraint             FK_tbl_orderdetail_productno foreign key (fk_productno)
                            references tbl_semi_product (productno)
    ,constraint             FK_tbl_orderdetail_userno foreign key (fk_userno)
                            references tbl_semi_member (userno)
    ,constraint             FK_tbl_orderl_statementno foreign key (fk_statementno)
                            references tbl_semi_statement (statementno)
);

-- 주문상세 시퀀스
create sequence seq_semi_orderdetail
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 장바구니 테이블
create table tbl_semi_cart
(
     cartno                 number not null             -- 장바구니 번호
    ,cartregisterday        date default sysdate        -- 장바구니 등록 날짜
    ,cartordercount         number                      -- 장바구니 주문 수량
    ,fk_productno           number                      -- 제품번호(외래키)
    ,constraint             PK_tbl_semi_cartno primary key(cartno)
    ,constraint             FK_tbl_semi_cart_productno foreign key (fk_productno)
                            references tbl_semi_product (productno)
);


-- 장바구니 시퀀스
create sequence seq_semi_cart
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 주문내역 테이블
create table tbl_semi_orderlist
(
     ordercompleteno            number not null             -- 주문완료번호
    ,paymentmode                nvarchar2(10)               -- 결제방식
    ,paymentname                nvarchar2(20)               -- 결제자 이름
    ,fk_orderdetailno           number                      -- 주문번호(외래키)
    ,fk_statementno             number                      -- 전표번호(외래키)
    ,fk_shippingno              number                      -- 배송번호(외래키)
    ,constraint                 PK_tbl_ordercompleteno primary key (ordercompleteno)
    ,constraint                 FK_tbl_orderlist_orderdetailno foreign key (fk_orderdetailno)
                                references tbl_semi_orderdetail (orderno)
    ,constraint                 FK_tbl_orderlist_statementno foreign key (fk_statementno)
                                references tbl_semi_statement (statementno)
    ,constraint                 FK_tbl_orderlist_shippingno foreign key (fk_shippingno)
                                references tbl_semi_shipping (shippingno)
);

-- 주문내역 시퀀스
create sequence seq_semi_orderlist
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 배송 테이블
create table tbl_semi_shipping
(
     shippingno             number not null             -- 배송번호
    ,shippingcode           nvarchar2(100) not null     -- 배송코드
    ,compnay                nvarchar2(100)              -- 배송회사명
    ,status                 number(1)                   -- 배송 상태 0:출고중 1: 배송중 2:완료
    ,constraint             PK_tbl_shippingno primary key (shippingno)
    ,constraint             UK_tbl_shippingcode unique (shippingcode)
);

-- 배송 시퀀스
create sequence seq_semi_shipping
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 상품정보 테이블
create table tbl_semi_productinfo
(
     fk_productno               number          -- 제품번호 (기본키, 외래키)
    ,productinfo                clob            -- 제품정보 
    ,fk_reviewno                number          -- 리뷰 글번호(외래키)
    ,constraint                 FK_tbl_productinfo_productno foreign key (fk_productno)
                                references tbl_semi_product (productno)
    ,constraint                 PK_tbl_productinfo_productno primary key (fk_productno)
    ,constraint                 FK_tbl_productinfo_reviewno foreign key (fk_reviewno)
                                references tbl_semi_review (reviewno)
);

-- 위시리스트 테이블
create table tbl_semi_wishlist
(
     wishlistno                 number                  -- 위시리스트 번호
    ,wregisterday               date default sysdate    -- 위시리스트 등록 날짜    
    ,fk_productno               number                  -- 제품번호(외래키)
    ,constraint                 PK_tbl_wishlist_wishlistno primary key (wishlistno)
    ,constraint                 FK_tbl_wishlist_productno foreign key (fk_productno)
                                references tbl_semi_product (productno)
);

-- 위시리스트 시퀀스
create sequence seq_semi_wishlist
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

    
    
    
    
