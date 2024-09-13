--멤버테이블
CREATE TABLE MEMBER (
	ID VARCHAR2(20) PRIMARY KEY
	,PASSWORD VARCHAR2(20) NOT NULL
	,NAME VARCHAR2(20) NOT NULL
	,BIRTH_DATE DATE NOT NULL
	,PHONE VARCHAR2(12) NOT NULL
	,POST 	CHAR(6) NOT NULL
	,BASIC_ADDR 	VARCHAR2(200) NOT NULL
	,DETAIL_ADDR 	VARCHAR2(200) NOT NULL
	,EMAIL VARCHAR2(50) NOT NULL UNIQUE
	,REG_DATE DATE DEFAULT SYSDATE
	,GRADE CHAR(1) DEFAULT 'B'
	,OAUTH CHAR(1)
	,ADMIN CHAR(1)
);

--견종테이블
CREATE TABLE BREED (
	NO NUMBER(10) PRIMARY KEY -- 견종코드
	,DOG_SIZE CHAR(1) NOT NULL -- S/M/L 애견사이즈
	,BREED_NAME VARCHAR(20) NOT NULL -- 견종 이름
);
CREATE SEQUENCE seq_BREED_no nocache;
-- 애완견테이블
CREATE TABLE DOG (
	NO NUMBER(10) PRIMARY KEY --애완견번호
	,MEMBER_ID VARCHAR2(20) NOT NULL --유저아이디
	,NAME VARCHAR2(20) NOT NULL -- 애완견이름
	,BIRTH_DATE DATE -- 애완견 생일
	,BREED_CODE NUMBER(5) NOT NULL -- 종 코드
	,CONSTRAINT FK_DOG_MEMBER_ID FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(ID) ON DELETE CASCADE
	,CONSTRAINT FK_DOG_BREED_CODE FOREIGN KEY(BREED_CODE) REFERENCES BREED(NO) ON DELETE CASCADE
	);
CREATE SEQUENCE seq_dog_no nocache;
--누적결제금액총합 테이블
CREATE TABLE ACC_PAY (
    NO NUMBER(10) PRIMARY KEY, -- 기본 키
    MEMBER_ID VARCHAR2(20) NOT NULL, -- 외래 키
    ACC_SUM NUMBER(20) DEFAULT 0 NOT NULL, -- 누적 결제 금액
    CONSTRAINT FK_PAYMENT_MEMBER_ID FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(ID) ON DELETE CASCADE -- 참조 키
);

-- 카테고리
CREATE TABLE CATEGORIES (
    C_CODE VARCHAR2(30) PRIMARY KEY, -- 기본 키
    C_NAME VARCHAR2(100) NOT NULL -- 카테고리명
);

-- 제품
CREATE TABLE PRODUCTS (
    P_CODE VARCHAR2(30) PRIMARY KEY, -- 기본 키
    P_NAME VARCHAR2(100) NOT NULL, -- 제품명
    P_PRICE NUMBER(10, 2) NOT NULL, -- 가격
    P_STOCK NUMBER NOT NULL, -- 재고 수량
    P_REG_DATE DATE DEFAULT SYSDATE -- 제품 등록 일시
    C_CODE VARCHAR2(30) NOT NULL,
    P_DETAIL VARCHAR2(1000),
);
ALTER TABLE PRODUCTS ADD FOREIGN KEY (C_CODE) REFERENCES CATEGORIES(C_CODE);

--주문
CREATE TABLE ORDERS (
    ORDER_no NUMBER PRIMARY KEY, -- 기본 키
    USER_ID VARCHAR2(20) NOT NULL, -- 외래 키
    P_CODE VARCHAR2(30) NOT NULL, -- 외래 키
    QUANTITY NUMBER NOT NULL, -- 수량
    PRICE NUMBER(10, 2) NOT NULL, -- 제품 가격 (주문 시점)
    O_REG_DATE DATE DEFAULT SYSDATE, -- 주문 생성 일시
    FOREIGN KEY (USER_ID) REFERENCES MEMBER(ID), -- 참조 키
    FOREIGN KEY (P_CODE) REFERENCES PRODUCTS(P_CODE) -- 참조 키
    sk
);
CREATE SEQUENCE seq_ORDERs_ORDER_NO nocache;

CREATE TABLE REVIEWS (
    REVIEW_NO NUMBER PRIMARY KEY, -- 기본 키
    P_CODE VARCHAR2(30), -- 외래 키
    USER_ID VARCHAR2(20), -- 외래 키
    RATING NUMBER CHECK (RATING BETWEEN 1 AND 5), -- 평점 (1-5)
    R_COMMENT VARCHAR2(4000), -- 리뷰 내용
    CREATED_AT DATE DEFAULT SYSDATE, -- 리뷰 작성 일시
    CONSTRAINT FK_REVIEW_P_CODE FOREIGN KEY (P_CODE) REFERENCES PRODUCTS(P_CODE) -- 참조 키
);
CREATE SEQUENCE seq_REVIEWS__REVIEW_NO nocache;

CREATE TABLE CART (
    C_NO NUMBER(10) PRIMARY KEY, -- 기본 키
    USER_ID VARCHAR2(20) NOT NULL, -- 유저 아이디
    P_CODE VARCHAR2(30) NOT NULL, -- 제품 아이디
    C_PRICE NUMBER(10, 2) NOT NULL,
    QUANTITY NUMBER NOT NULL, -- 수량
    C_REG_DATE DATE DEFAULT SYSDATE,-- 추가된 일시
    c_price NUMBER(10, 2) NOT NULL,
    FOREIGN KEY (USER_ID) REFERENCES MEMBER(ID) ON DELETE CASCADE, -- 참조 키
    FOREIGN KEY (P_CODE) REFERENCES PRODUCTS(P_CODE) -- 참조 키
);
CREATE SEQUENCE seq_CART_CART_NO nocache;

CREATE TABLE PRODUCT_IMAGES (
    IMG_NO NUMBER(10) PRIMARY KEY, -- 기본 키
    P_CODE VARCHAR2(30), -- 외래 키
    IMG_LINK VARCHAR2(200) NOT NULL,
    IMG_TYPE CHAR(1) NOT NULL,--미리보기, 상세보기 이미지 구분 'P', 'D'
    FOREIGN KEY (P_CODE) REFERENCES PRODUCTS(P_CODE) -- 참조 키  
);

COMMIT;

=======================================================================
=======================================================================
DB링크 설정

CREATE DATABASE LINK DOG_XE CONNECT TO dogworld identified BY "dog1234" 
USING '(DESCRIPTION = 
		(ADDRESS = (PROTOCOL=TCP)(HOST=172.31.9.175)(PORT=1521)) 
		(CONNECT_DATA = 
		(SERVER = DEDICATED) 
		(SERVICE_NAME = XE) 
		) 
)'; 

--오라클 tnsnames.ora 파일에 추가 
--DOG_XE = 
--  (DESCRIPTION = 
--    (ADDRESS = (PROTOCOL=TCP)(HOST=172.31.9.175)(PORT=1521)) 
--    (CONNECT_DATA = 
--      (SERVER = DEDICATED) 
--      (SERVICE_NAME = XE) 
--    ) 
--  ) 

COMMIT;
=======================================================================
=======================================================================

DB링크 추가후 멤버테이블 무결성을 위한 트리거 설정

-- 원격 멤버테이블 장바구니 트리거 설정
CREATE OR REPLACE TRIGGER check_member_fk
BEFORE INSERT OR UPDATE OR DELETE ON CART --INSERT나 UPDATE, DELETE실행시 트리거 발생
FOR EACH ROW -- 각행에 대해
DECLARE
    v_count NUMBER;	--ID가 일치한지 카운트를 저장하는 변수
BEGIN
    -- 원격 데이터베이스의 MEMBER 테이블을 확인
    SELECT COUNT(*)
    INTO v_count
    FROM MEMBER@DOG_XE
    WHERE ID = :NEW.USER_ID;    
    IF v_count = 0 THEN --일치하는 아이디가 존재하지않을떄
        -- 원격 데이터베이스에 USER_ID가 존재하지 않으면 에러 발생
        RAISE_APPLICATION_ERROR(-20000, 'Invalid USER_ID, reference does not exist in MEMBER table');
    END IF;
END;

CREATE OR REPLACE TRIGGER check_member_fk_orders
BEFORE INSERT OR UPDATE ON ORDERS
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    -- 원격 데이터베이스의 MEMBER 테이블을 확인
    SELECT COUNT(*)
    INTO v_count
    FROM MEMBER@DOG_XE
    WHERE ID = :NEW.USER_ID;
    
    IF v_count = 0 THEN
        -- 원격 데이터베이스에 USER_ID가 존재하지 않으면 에러 발생
        RAISE_APPLICATION_ERROR(-20000, 'Invalid USER_ID, reference does not exist in MEMBER table');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER check_member_fk_reviews
BEFORE INSERT OR UPDATE OR DELETE  ON reviews
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM MEMBER@DOG_XE
    WHERE ID = :NEW.USER_ID; 
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'Invalid USER_ID, reference does not exist in MEMBER table');
    END IF;
END;
/


=======================================================================
=======================================================================
--데이터 추가
---유저
INSERT INTO "MEMBER" (ID, PASSWORD, NAME, BIRTH_DATE, PHONE, POST, BASIC_ADDR, DETAIL_ADDR, EMAIL, ADMIN)
VALUES('imhs0203', 'qwe123', '임현수', '2000-02-03', '01074737692', '13639', '경기도 성남시 수정구 위례순환로100(창곡동, 위례자이)', '3305동 302호', 'hsim0203@naver.com', 'A');
COMMIT;

INSERT INTO BREED ( NO , DOG_SIZE, BREED_NAME)
VALUES(seq_BREED_no.nextval, 'B', 'GOLDEN RETRIEVER');

INSERT INTO BREED ( NO , DOG_SIZE, BREED_NAME)
VALUES(seq_BREED_no.nextval, 'B', 'SIBERIAN HUSKY');

INSERT INTO DOG (NO, MEMBER_ID, NAME, BIRTH_DATE, BREED_CODE)
VALUES(seq_dog_no.nextval, 'imhs0203', '강아지', '2016-01-01', '1');

INSERT INTO DOG (NO, MEMBER_ID, NAME, BIRTH_DATE, BREED_CODE)
VALUES(seq_dog_no.nextval, 'imhs0203', '강아지', '2016-01-01', '1');

COMMIT;
--리뷰
INSERT INTO REVIEWS (REVIEW_NO , P_CODE, USER_ID, RATING, R_COMMENT)
VALUES(seq_REVIEWS__REVIEW_NO.nextval, 'FE0012', 'imhs0203', '5', '배송이 정말 빨라서 좋아요!!');

INSERT INTO REVIEWS (REVIEW_NO , P_CODE, USER_ID, RATING, R_COMMENT)
VALUES(seq_REVIEWS__REVIEW_NO.nextval, 'FE0012', 'imhs0203', '4', '택배상자가 조금 구겨져서 왔지만 상품은 좋아요');

INSERT INTO REVIEWS (REVIEW_NO , P_CODE, USER_ID, RATING, R_COMMENT)
VALUES(seq_REVIEWS__REVIEW_NO.nextval, 'FE0012', 'imhs0203', '5', '정말 만족합니다');
------데이터
--카테고리
--사료
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10001', '건식사료');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10002', '습식사료');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10003', '우유/분유');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10004', '영양제');
--간식
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10101', '강아지껌');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10102', '비스켓/스낵');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10103', '육포');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10104', '캔');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10105', '기타간식');
--위생용품
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10201', '배변판');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10202', '배변패드');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10203', '배변봉투');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10204', '기저귀');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10205', '구강위생용품');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10206', '탈취제');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10207', '넥카라');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10208', '해충방지제');
--미용용품
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10301', '샴푸');
--식기
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10401', '급수기');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10402', '급식기');
--외출용픔
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10501', '목줄');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10502', '이동가방');
--장난감
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10601', '공');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10602', '원반');
--안전용품
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10701', '매트');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10702', '울타리');
INSERT INTO CATEGORIES (C_CODE, C_NAME)
VALUES('10703', '쿠션');

--제품
--
INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE)
VALUES('FE0001', '노브랜드 애완견 사료', 6000, 80, '10001')

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE)
VALUES('FE0002', '성견용 진돗개 사료 도그썬 진도견용 10kg', 30100, 100, '10001');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE)
VALUES('FE0003', '퍼피아이 Q 전견용 5kg', 22700, 50, '10002');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE)
VALUES('FE0004', '비아파 락톨 퍼피 500g', 36000, 70, '10003');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE)
VALUES('SN0001', '리틀달링 치킨 우유껌 6개입', 1200, 1000, '10101');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE)
VALUES('SN0003', '네츄럴코어 멍쵸 10g 4종 콤보 20개', 6000, 500, '10102');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE)
VALUES('SN0002', '프롬네이처 연어 슬라이스 300g', 3000, 400, '10103');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE)
VALUES('SN0004', 'ANF 치킨 순살 캔 95g', 2000, 400, '10104');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE)
VALUES('SN0005', '헤세드요셉 맛있구마 말랑큐브 고구마 200g', 3000, 500, '10105');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('SP0001', '네이처펫 논슬립 실리콘 배변판 표준형 그레이', 10900, 100, '10201', '원산지 - 중국, 소재/재질 - 실리콘, 사이즈(가로,세로) - 60X50cm');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('SP0002', '네이처펫 슈슈 배변 패드 실속형 100매', 7500, 150, '10202', '원산지 - 중국, 소재/재질 - 안감:부직포/흡수층:분쇄펄프,고흡수성수지(SAP)/방수막:폴리에틸렌필름, 사이즈(가로,세로) - 50X40cm');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('SP0003', '펫투데이 향기나는 친환경 생분해 배변봉투 8롤 144매', 7000, 500, '10203', '원산지 - 중국, 소재/재질 - HDPE+EPI, 제조사/수입사 - 펫투데이/펫투데이');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('SP0004', '루나 매너가드 수컷용 배변 기저귀 M', 3800, 500, '10204', '원산지 - 중국, 소재/재질 - PE/부직포/펄프/SAP, 제조사/수입사 - SHANDONG JINGXIN/(주)펫스토리');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('SP0005', '펫모닝 올바디 펫티슈 펫둥이 물티슈 70매', 3500, 500, '10205', '원산지 - 한국, 유통기한 - 18개월 / 2026년 04월 24일 이후, 제조사/수입사 - 피앤티');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('SP0006', '더 바론샘 살균탈취제 120ml', 3500, 500, '10206', '원산지 - 한국, 유통기한 - 24개월 / 2025년 02월 12일 이후, 제조사/수입사 - 펫츠다이닝');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('SP0007', '힐링타임 도넛 쿠션 넥카라 뉴욕스타 NH-363 S size', 10000, 100, '10207', '원산지 - 한국, 소재/재질 - 폴리에스테르/구름솜, 제조사/수입사 - 힐링타임');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('SP0008', '필루 천연 해충방지 목걸이 대형견용', 11800, 200, '10208', '원산지 - 프랑스');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('BS0001', '포켄스 포비스 베이비파우더 샴푸 550ml', 7200, 200, '10301', '원산지 - 한국, 유통기한 - 36개월 / 2027년 01월 09일 이후, 제조사/수입사 - 포켄스');
 
INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('FE0005', '오리젠 사료 오리지널 독 11.4kg', 144000, 500, '10001', '원산지 - 캐나다, 유통기한 - 18개월 / 2025년 11월 08일 이후, 제조사/수입사 - 
챔피온펫푸드/두원실업(주), 권장연령 - 모든연령');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('FE0006', '청담닥터스랩 강아지 가수분해 사료 데일리솔루션 스킨&코트 5kg', 64900, 500, '10001', '원산지 - 한국, 유통기한 - 18개월 / 2025년 11월 27일 이후, 제조사/수입사 - 
에이티바이오, 권장연령 - 생후 2개월 이상');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('FE0007', '오리젠 사료 퍼피 독 2kg', 38000, 1000, '10001', '원산지 - 캐나다, 유통기한 - 18개월 / 2025년 02월 03일 이후, 제조사/수입사 - 
챔피온펫푸드/두원실업(주), 권장연령 - 1세 이하');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('FE0008', '뉴트리나 건강백서 사료 건강한 체중 6kg', 48000, 500, '10001', '원산지 - 한국, 유통기한 - 18개월 / 2025년 08월 28일 이후, 제조사/수입사 - 
카길애그리퓨리나, 권장연령 - 모든연령');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('FE0009', '로얄캐닌 강아지사료 맥시 어덜트 4kg', 46000, 1000, '10001', '원산지 - 프랑스, 유통기한 - 18개월 / 2025년 12월 03일 이후, 제조사/수입사 - 
로얄캐닌/로얄캐닌코리아, 권장연령 - 생후 15개월 이후');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('FE0010', '네츄럴코어 사료 센시티브케어 밀웜 작은알갱이 3kg', 45000, 1000, '10001', '원산지 - 한국, 유통기한 - 18개월 / 2025년 08월 15일 이후, 제조사/수입사 - 
이레본, 권장연령 - 생후 2개월령 이상');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('FE0011', '로얄캐닌 강아지사료 라브라도리트리버 어덜트 12kg', 120000, 500, '10001', '원산지 - 프랑스, 유통기한 - 18개월 / 2025년 02월 03일 이후, 제조사/수입사 - 로얄캐닌, 권장연령 - 생후 15개월 이후');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('FE0012', '오리젠 사료 스몰브리드 독 1.8kg', 38000, 1000, '10001', '원산지 - 캐나다, 유통기한 - 18개월 / 2025년 10월 10일 이후, 제조사/수입사 - 챔피온펫푸드/두원실업(주), 권장연령 - 모든연령');

INSERT INTO PRODUCTS (P_CODE, P_NAME, P_PRICE, P_STOCK, C_CODE, P_DETAIL)
VALUES('FE0011', '로얄캐닌 강아지사료 라브라도리트리버 어덜트 12kg', 120000, 500, '10001', '원산지 - 프랑스, 유통기한 - 18개월 / 2025년 02월 03일 이후, 제조사/수입사 - 로얄캐닌, 권장연령 - 생후 15개월 이후');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0002', 'https://puppydog.co.kr/web/product/medium/202406/94b64e6792d30cd2a6fec267c3e788b7.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0002', 'https://dc1000u.hgodo.com/pet1/2022/07/1000000102-0.jpg', 'D');


INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0003', 'https://puppydog.co.kr/web/product/medium/202405/a960104f075b451743097b0104e5c059.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0003', 'https://aplus3579.cafe24.com///web/sabangnet/allagedog_5kg.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0004', 'https://puppydog.co.kr/web/product/medium/202406/8989808e521615974f7b601943cbe7a4.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0004', 'https://gi.esmplus.com/pomi2907/20230328/1000004363.jpg', 'D');


INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SN0001', 'https://cdn.dogpang.com/catpang/data/goods/6/5610_web_original_1671698483333942.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SN0001', 'https://cdn.dogpang.com/catpang/data/goods/6/5610_web_detailView_1671698483225556.jpg', 'D');

INSERT INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SN0002', 'https://cdn.dogpang.com/catpang/data/goods/6/5596_web_original_1601967189317729.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SN0002', 'https://cdn.dogpang.com/catpang/data/goods/6/5596_web_detailView_1601967189932108.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SN0003', 'https://cdn.dogpang.com/catpang/data/view/12/C000011464_web_original_1691114716234740.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SN0003', 'https://cdn.dogpang.com/catpang/data/view/12/C000011464_web_detailView_1691114716342454.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SN0004', 'https://cdn.dogpang.com/catpang/data/goods/6/5324_web_original_1586841630993017.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SN0004', 'https://cdn.dogpang.com/catpang/data/goods/6/5324_web_detailView_1586841630364511.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SN0005', 'https://cdn.dogpang.com/catpang/data/goods/10/9893_web_original_16944816075297.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SN0005', 'https://cdn.dogpang.com/catpang/data/goods/10/9893_web_detailView_1694481607838527.jpg', 'P');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0001', 'https://cdn.dogpang.com/catpang/data/view/12/N000011602_web_original_169468297429178.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0001', 'https://cdn.dogpang.com/catpang/data/view/12/N000011602_web_detailView_1694682948958037.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0002', 'https://cdn.dogpang.com/catpang/data/goods/10/9861_web_original_1694505411893429.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0002', 'https://cdn.dogpang.com/catpang/data/goods/10/9861_web_detailView_1693985912167812.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0003', 'https://cdn.dogpang.com/catpang/data/goods/10/9988_web_original_1700027682512610.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0003', 'https://cdn.dogpang.com/catpang/data/goods/10/9988_web_detailView_1700027682898751.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0004', 'https://cdn.dogpang.com/catpang/data/goods/8/7178_web_original_1619574377199543.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0004', 'https://cdn.dogpang.com/catpang/data/goods/8/7178_web_detailView_1597036969884027.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0005', 'https://cdn.dogpang.com/catpang/data/goods/8/7407_web_original_1608096307716670.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0005', 'https://cdn.dogpang.com/catpang/data/goods/8/7407_web_detailView_1606196006634973.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0006', 'https://cdn.dogpang.com/catpang/data/goods/10/9842_web_original_1693454948717957.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0006', 'https://cdn.dogpang.com/catpang/data/goods/10/9842_web_detailView_1693454920167896.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0007', 'https://cdn.dogpang.com/catpang/data/goods/5/4470_web_original_1594801900763507.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0007', 'https://cdn.dogpang.com/catpang/data/goods/5/4470_web_detailView_1564992442456789.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0008', 'https://cdn.dogpang.com/catpang/data/goods/7/6593_web_original_1592377169510886.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'SP0008', 'https://cdn.dogpang.com/catpang/data/goods/7/6593_web_detailView_1592377169855398.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'BS0001', 'https://cdn.dogpang.com/catpang/data/goods/6/5274_web_original_162305524519527.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'BS0001', 'https://cdn.dogpang.com/catpang/data/goods/6/5274_web_detailView_1586763521250078.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0005', 'https://cdn.dogpang.com/catpang/data/goods/6/5462_web_original_1669189041674958.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0005', 'https://cdn.dogpang.com/catpang/data/goods/6/5462_web_detailView_1669189041800342.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0006', 'https://cdn.dogpang.com/catpang/data/goods/10/9017_web_original_1681200973498689.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0006', 'https://cdn.dogpang.com/catpang/data/goods/10/9017_web_detailView_1656468609617091.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0007', 'https://cdn.dogpang.com/catpang/data/goods/6/5457_web_original_1691731410733812.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0007', 'https://cdn.dogpang.com/catpang/data/goods/6/5457_web_detailView_1691730089569854.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0008', 'https://cdn.dogpang.com/catpang/data/goods/8/7552_web_original_1629357417959057.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0008', 'https://cdn.dogpang.com/catpang/data/goods/8/7552_web_detailView_1610012751647271.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0009', 'https://cdn.dogpang.com/catpang/data/goods/8/7775_web_original_1719284674607231.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0009', 'https://cdn.dogpang.com/catpang/data/goods/8/7775_web_detailView_1616123084113555.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0010', 'https://cdn.dogpang.com/catpang/data/goods/9/8612_web_original_1637297125272420.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0010', 'https://cdn.dogpang.com/catpang/data/goods/9/8612_web_detailView_1637297125596648.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0011', 'https://cdn.dogpang.com/catpang/data/goods/9/8631_web_original_1638184335252491.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0011', 'https://cdn.dogpang.com/catpang/data/goods/9/8631_web_detailView_1638183863866128.jpg', 'D');

INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0012', 'https://cdn.dogpang.com/catpang/data/goods/8/7509_web_original_166918589249265.jpg', 'P');
INSERT INTO PRODUCT_IMAGES (IMG_NO, P_CODE, IMG_LINK, IMG_TYPE)
VALUES(seq_PRODUCT_IMAGES_IMAGE_NO.nextval, 'FE0012', 'https://cdn.dogpang.com/catpang/data/goods/8/7509_web_detailView_1669185892929996.jpg', 'D');


COMMIT;