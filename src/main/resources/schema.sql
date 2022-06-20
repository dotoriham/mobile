-- Table: public.account
CREATE TABLE IF NOT EXISTS public.account
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    background_color character varying(30) COLLATE pg_catalog."default",
    email character varying(60) COLLATE pg_catalog."default",
    fcm_token character varying(255) COLLATE pg_catalog."default",
    image character varying(255) COLLATE pg_catalog."default",
    name character varying(40) COLLATE pg_catalog."default",
    password character varying(200) COLLATE pg_catalog."default",
    remind_cycle integer,
    remind_toggle boolean,
    social_type character varying(20) COLLATE pg_catalog."default",
    deleted boolean,
    CONSTRAINT account_pkey PRIMARY KEY (id),
    CONSTRAINT uk_q0uja26qgu1atulenwup9rxyr UNIQUE (email)
);

ALTER TABLE public.account
    OWNER to yapp;

COMMENT ON COLUMN public.account.id
    IS '회원 ID';

COMMENT ON COLUMN public.account.created_at
    IS '생성 일시';

COMMENT ON COLUMN public.account.updated_at
    IS '수정 일시';

COMMENT ON COLUMN public.account.background_color
    IS '배경 색상';

COMMENT ON COLUMN public.account.email
    IS '이메일';

COMMENT ON COLUMN public.account.fcm_token
    IS 'FCM 토큰';

COMMENT ON COLUMN public.account.image
    IS '프로필 이미지';

COMMENT ON COLUMN public.account.name
    IS '닉네임';

COMMENT ON COLUMN public.account.password
    IS '비밀번호';

COMMENT ON COLUMN public.account.remind_cycle
    IS '리마인드 주기(3일, 7일, 14일, 30일)';

COMMENT ON COLUMN public.account.remind_toggle
    IS '리마인드 토글 여부';

COMMENT ON COLUMN public.account.social_type
    IS '소셜로그인 유형';

COMMENT ON COLUMN public.account.deleted
    IS '회원 탈퇴 여부';


-- Table: public.folder
CREATE TABLE IF NOT EXISTS public.folder
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    bookmark_count integer NOT NULL,
    emoji character varying(100) COLLATE pg_catalog."default",
    index integer NOT NULL,
    name character varying(40) COLLATE pg_catalog."default",
    parent_id bigint,
    CONSTRAINT folder_pkey PRIMARY KEY (id),
    CONSTRAINT fkn0cjh1seljcp0mc4tj1ufh99m FOREIGN KEY (parent_id)
    REFERENCES public.folder (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE
);

ALTER TABLE public.folder
    OWNER to yapp;

COMMENT ON COLUMN public.folder.id
    IS '폴더 ID';

COMMENT ON COLUMN public.folder.created_at
    IS '생성 일시';

COMMENT ON COLUMN public.folder.updated_at
    IS '수정 일시';

COMMENT ON COLUMN public.folder.bookmark_count
    IS '북마크 갯수';

COMMENT ON COLUMN public.folder.emoji
    IS '이모지';

COMMENT ON COLUMN public.folder.index
    IS '폴더 순서(계층형 구조)';

COMMENT ON COLUMN public.folder.name
    IS '폴더 이름';

COMMENT ON COLUMN public.folder.parent_id
    IS '상위 폴더 ID';


-- Table: public.account_folder
CREATE TABLE IF NOT EXISTS public.account_folder
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    account_id bigint,
    folder_id bigint,
    authority character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT account_folder_pkey PRIMARY KEY (id),
    CONSTRAINT fkpu24hyoea9vik0oexl3j8r2tu FOREIGN KEY (account_id)
    REFERENCES public.account (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    CONSTRAINT fkq12fenyrw4agbqxdkoe9j9t0 FOREIGN KEY (folder_id)
    REFERENCES public.folder (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE
);

ALTER TABLE public.account_folder
    OWNER to yapp;

COMMENT ON COLUMN public.account_folder.id
    IS 'account_folder ID';

COMMENT ON COLUMN public.account_folder.account_id
    IS '회원 ID';

COMMENT ON COLUMN public.account_folder.folder_id
    IS '폴더 ID';

COMMENT ON COLUMN public.account_folder.authority
    IS '공유 보관함 관련 권한';