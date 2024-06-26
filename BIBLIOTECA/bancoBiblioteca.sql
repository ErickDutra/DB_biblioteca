PGDMP  !                     |         
   Biblioteca    15.7    16.3 C    B           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            C           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            D           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            E           1262    16398 
   Biblioteca    DATABASE     �   CREATE DATABASE "Biblioteca" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "Biblioteca";
                postgres    false            �            1255    16533    alertatraso()    FUNCTION     �   CREATE FUNCTION public.alertatraso() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

begin
 if new.data_entrega > new.data_prevista then
	raise notice 'Livro entrege com atraso.';
end if;
return new;
end;
$$;
 $   DROP FUNCTION public.alertatraso();
       public          postgres    false            �            1255    16526 !   atualizar_autor(integer, integer) 	   PROCEDURE     �   CREATE PROCEDURE public.atualizar_autor(IN idlivro integer, IN idautor integer)
    LANGUAGE plpgsql
    AS $$
	begin 
		update livro
		set id_autor = idAutor
		where id = idLivro;
commit;
end $$;
 O   DROP PROCEDURE public.atualizar_autor(IN idlivro integer, IN idautor integer);
       public          postgres    false            �            1255    16524    atualizar_data(integer, date) 	   PROCEDURE     �   CREATE PROCEDURE public.atualizar_data(IN idlivro integer, IN novadata date)
    LANGUAGE plpgsql
    AS $$
	begin 
		update livro
		set ano_publicacao = novaData
		where id = idLivro;
commit;
end $$;
 L   DROP PROCEDURE public.atualizar_data(IN idlivro integer, IN novadata date);
       public          postgres    false            �            1255    24672 &   atualizar_data_prevista(integer, date) 	   PROCEDURE     �   CREATE PROCEDURE public.atualizar_data_prevista(IN idemprestimo integer, IN novadata date)
    LANGUAGE plpgsql
    AS $$
	begin 
		update emprestimo
		set data_prevista = novaData
		where id = idEmprestimo;
commit;
end $$;
 Z   DROP PROCEDURE public.atualizar_data_prevista(IN idemprestimo integer, IN novadata date);
       public          postgres    false            �            1255    16525 #   atualizar_editora(integer, integer) 	   PROCEDURE     �   CREATE PROCEDURE public.atualizar_editora(IN idlivro integer, IN ideditora integer)
    LANGUAGE plpgsql
    AS $$
	begin 
		update livro
		set id_editora = idEditora
		where id = idLivro;
commit;
end $$;
 S   DROP PROCEDURE public.atualizar_editora(IN idlivro integer, IN ideditora integer);
       public          postgres    false            �            1255    16520 +   atualizar_email(integer, character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.atualizar_email(IN idusuario integer, IN novoemail character varying)
    LANGUAGE plpgsql
    AS $$
	begin 
		update usuario
		set email = novoEmail
		where id = idUsuario;
commit;
end $$;
 ]   DROP PROCEDURE public.atualizar_email(IN idusuario integer, IN novoemail character varying);
       public          postgres    false            �            1255    16521 *   atualizar_nome(integer, character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.atualizar_nome(IN idusuario integer, IN novonome character varying)
    LANGUAGE plpgsql
    AS $$
	begin 
		update usuario
		set nome = novoNome
		where id = idUsuario;
commit;
end $$;
 [   DROP PROCEDURE public.atualizar_nome(IN idusuario integer, IN novonome character varying);
       public          postgres    false            �            1255    16522 ,   atualizar_titulo(integer, character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.atualizar_titulo(IN idlivro integer, IN novotitulo character varying)
    LANGUAGE plpgsql
    AS $$
	begin 
		update livro
		set titulo = novoTitulo
		where id = idLivro;
commit;
end $$;
 ]   DROP PROCEDURE public.atualizar_titulo(IN idlivro integer, IN novotitulo character varying);
       public          postgres    false            �            1255    16538 !   devolucao_livro(integer, integer) 	   PROCEDURE       CREATE PROCEDURE public.devolucao_livro(IN idlivro integer, IN usuario integer)
    LANGUAGE plpgsql
    AS $$
	declare
	entrega date := CURRENT_DATE;
begin
	update emprestimo
	set data_entrega = entrega
	where id_livro = idLivro and id_usuario = usuario;
	
COMMIT;
end $$;
 O   DROP PROCEDURE public.devolucao_livro(IN idlivro integer, IN usuario integer);
       public          postgres    false            �            1255    16541 "   emprestimo_livro(integer, integer) 	   PROCEDURE     q  CREATE PROCEDURE public.emprestimo_livro(IN id_livro integer, IN usuario integer)
    LANGUAGE plpgsql
    AS $$
	declare 
	data_prevista date:= CURRENT_DATE;
	data_aluguel date := CURRENT_DATE;
	quantidade_livros_sem_devolucao INTEGER;
begin
	select count(*) into quantidade_livros_sem_devolucao 
	from emprestimo
	where id_usuario = usuario and data_entrega is null;

	if quantidade_livros_sem_devolucao >= 3 THEN
	raise exception 'você atingiu a quantidade maxima';
	end if;

	insert into emprestimo(data_prevista,data_aluguel,id_livro,id_usuario)
	values(data_prevista, data_aluguel, id_livro, usuario);
COMMIT;
end $$;
 Q   DROP PROCEDURE public.emprestimo_livro(IN id_livro integer, IN usuario integer);
       public          postgres    false            �            1255    16529    incrementempretimo()    FUNCTION     �   CREATE FUNCTION public.incrementempretimo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
new.data_prevista := CURRENT_DATE + INTERVAL '3 days';
return new;
end;
$$;
 +   DROP FUNCTION public.incrementempretimo();
       public          postgres    false            �            1255    16504 8   inserir_livro(character varying, integer, integer, date)    FUNCTION     Q  CREATE FUNCTION public.inserir_livro(titulo character varying, id_autor integer, id_editora integer, ano_publicacao date) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO livro(titulo, id_autor,id_editora, ano_publicacao) VALUES(titulo,id_autor, id_editora,ano_publicacao);
	RETURN 'INSERIDO COM SUCESSO';
COMMIT;
END;
$$;
 y   DROP FUNCTION public.inserir_livro(titulo character varying, id_autor integer, id_editora integer, ano_publicacao date);
       public          postgres    false            �            1255    16505 4   inserir_telefone(integer, integer, integer, integer)    FUNCTION     ,  CREATE FUNCTION public.inserir_telefone(sufixo integer, ddd integer, numero integer, id_usuario integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO telefone(sufixo, ddd, numero, id_usuario) VALUES(sufixo, ddd, numero, id_usuario);
	RETURN 'INSERIDO COM SUCESSO';
COMMIT;
END;
$$;
 h   DROP FUNCTION public.inserir_telefone(sufixo integer, ddd integer, numero integer, id_usuario integer);
       public          postgres    false            �            1255    16540 $   renovar_emprestimo(integer, integer) 	   PROCEDURE     `  CREATE PROCEDURE public.renovar_emprestimo(IN idlivro integer, IN usuario integer)
    LANGUAGE plpgsql
    AS $$
	declare
	data_atual date := CURRENT_DATE;
begin
	update emprestimo
	set data_aluguel = data_atual,
	data_entrega = null,
	data_prevista = data_atual + INTERVAL '3 days'
	where id_livro = idLivro and id_usuario = usuario;
COMMIT;
end $$;
 R   DROP PROCEDURE public.renovar_emprestimo(IN idlivro integer, IN usuario integer);
       public          postgres    false            �            1259    16400    autor    TABLE     a   CREATE TABLE public.autor (
    id integer NOT NULL,
    nome character varying(100) NOT NULL
);
    DROP TABLE public.autor;
       public         heap    postgres    false            �            1259    16399    autor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.autor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.autor_id_seq;
       public          postgres    false    215            F           0    0    autor_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.autor_id_seq OWNED BY public.autor.id;
          public          postgres    false    214            �            1259    16407    editora    TABLE     c   CREATE TABLE public.editora (
    id integer NOT NULL,
    nome character varying(100) NOT NULL
);
    DROP TABLE public.editora;
       public         heap    postgres    false            �            1259    16406    editora_id_seq    SEQUENCE     �   CREATE SEQUENCE public.editora_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.editora_id_seq;
       public          postgres    false    217            G           0    0    editora_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.editora_id_seq OWNED BY public.editora.id;
          public          postgres    false    216            �            1259    16452 
   emprestimo    TABLE     �   CREATE TABLE public.emprestimo (
    id integer NOT NULL,
    data_entrega date,
    data_prevista date NOT NULL,
    data_aluguel date NOT NULL,
    id_livro integer NOT NULL,
    id_usuario integer NOT NULL
);
    DROP TABLE public.emprestimo;
       public         heap    postgres    false            �            1259    16451    emprestimo_id_seq    SEQUENCE     �   CREATE SEQUENCE public.emprestimo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.emprestimo_id_seq;
       public          postgres    false    223            H           0    0    emprestimo_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.emprestimo_id_seq OWNED BY public.emprestimo.id;
          public          postgres    false    222            �            1259    16488    livro    TABLE     �   CREATE TABLE public.livro (
    id integer NOT NULL,
    titulo character varying(255),
    id_autor integer,
    id_editora integer,
    ano_publicacao date
);
    DROP TABLE public.livro;
       public         heap    postgres    false            �            1259    16487    livro_id_seq    SEQUENCE     �   CREATE SEQUENCE public.livro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.livro_id_seq;
       public          postgres    false    225            I           0    0    livro_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.livro_id_seq OWNED BY public.livro.id;
          public          postgres    false    224            �            1259    16414    telefone    TABLE     �   CREATE TABLE public.telefone (
    id integer NOT NULL,
    sufixo integer NOT NULL,
    ddd integer NOT NULL,
    numero integer NOT NULL,
    id_usuario integer
);
    DROP TABLE public.telefone;
       public         heap    postgres    false            �            1259    16413    telefone_id_seq    SEQUENCE     �   CREATE SEQUENCE public.telefone_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.telefone_id_seq;
       public          postgres    false    219            J           0    0    telefone_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.telefone_id_seq OWNED BY public.telefone.id;
          public          postgres    false    218            �            1259    16438    usuario    TABLE     �   CREATE TABLE public.usuario (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    data_registro date NOT NULL
);
    DROP TABLE public.usuario;
       public         heap    postgres    false            �            1259    16437    usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.usuario_id_seq;
       public          postgres    false    221            K           0    0    usuario_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;
          public          postgres    false    220            �           2604    16403    autor id    DEFAULT     d   ALTER TABLE ONLY public.autor ALTER COLUMN id SET DEFAULT nextval('public.autor_id_seq'::regclass);
 7   ALTER TABLE public.autor ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            �           2604    16410 
   editora id    DEFAULT     h   ALTER TABLE ONLY public.editora ALTER COLUMN id SET DEFAULT nextval('public.editora_id_seq'::regclass);
 9   ALTER TABLE public.editora ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    16455    emprestimo id    DEFAULT     n   ALTER TABLE ONLY public.emprestimo ALTER COLUMN id SET DEFAULT nextval('public.emprestimo_id_seq'::regclass);
 <   ALTER TABLE public.emprestimo ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    223    223            �           2604    16491    livro id    DEFAULT     d   ALTER TABLE ONLY public.livro ALTER COLUMN id SET DEFAULT nextval('public.livro_id_seq'::regclass);
 7   ALTER TABLE public.livro ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    224    225            �           2604    16417    telefone id    DEFAULT     j   ALTER TABLE ONLY public.telefone ALTER COLUMN id SET DEFAULT nextval('public.telefone_id_seq'::regclass);
 :   ALTER TABLE public.telefone ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219            �           2604    16441 
   usuario id    DEFAULT     h   ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);
 9   ALTER TABLE public.usuario ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            5          0    16400    autor 
   TABLE DATA           )   COPY public.autor (id, nome) FROM stdin;
    public          postgres    false    215   ZU       7          0    16407    editora 
   TABLE DATA           +   COPY public.editora (id, nome) FROM stdin;
    public          postgres    false    217   �U       =          0    16452 
   emprestimo 
   TABLE DATA           i   COPY public.emprestimo (id, data_entrega, data_prevista, data_aluguel, id_livro, id_usuario) FROM stdin;
    public          postgres    false    223   �U       ?          0    16488    livro 
   TABLE DATA           Q   COPY public.livro (id, titulo, id_autor, id_editora, ano_publicacao) FROM stdin;
    public          postgres    false    225   pV       9          0    16414    telefone 
   TABLE DATA           G   COPY public.telefone (id, sufixo, ddd, numero, id_usuario) FROM stdin;
    public          postgres    false    219   W       ;          0    16438    usuario 
   TABLE DATA           A   COPY public.usuario (id, nome, email, data_registro) FROM stdin;
    public          postgres    false    221   aW       L           0    0    autor_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.autor_id_seq', 16, true);
          public          postgres    false    214            M           0    0    editora_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.editora_id_seq', 4, true);
          public          postgres    false    216            N           0    0    emprestimo_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.emprestimo_id_seq', 13, true);
          public          postgres    false    222            O           0    0    livro_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.livro_id_seq', 4, true);
          public          postgres    false    224            P           0    0    telefone_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.telefone_id_seq', 4, true);
          public          postgres    false    218            Q           0    0    usuario_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.usuario_id_seq', 7, true);
          public          postgres    false    220            �           2606    16405    autor autor_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.autor
    ADD CONSTRAINT autor_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.autor DROP CONSTRAINT autor_pkey;
       public            postgres    false    215            �           2606    16412    editora editora_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.editora
    ADD CONSTRAINT editora_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.editora DROP CONSTRAINT editora_pkey;
       public            postgres    false    217            �           2606    16457    emprestimo emprestimo_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.emprestimo
    ADD CONSTRAINT emprestimo_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.emprestimo DROP CONSTRAINT emprestimo_pkey;
       public            postgres    false    223            �           2606    16493    livro livro_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.livro
    ADD CONSTRAINT livro_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.livro DROP CONSTRAINT livro_pkey;
       public            postgres    false    225            �           2606    16419    telefone telefone_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT telefone_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.telefone DROP CONSTRAINT telefone_pkey;
       public            postgres    false    219            �           2606    16445    usuario usuario_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);
 C   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_email_key;
       public            postgres    false    221            �           2606    16443    usuario usuario_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            postgres    false    221            �           2620    16530 #   emprestimo trg_increment_emprestimo    TRIGGER     �   CREATE TRIGGER trg_increment_emprestimo BEFORE INSERT ON public.emprestimo FOR EACH ROW EXECUTE FUNCTION public.incrementempretimo();
 <   DROP TRIGGER trg_increment_emprestimo ON public.emprestimo;
       public          postgres    false    233    223            �           2620    16534     emprestimo trigger_alerta_atraso    TRIGGER     �   CREATE TRIGGER trigger_alerta_atraso BEFORE UPDATE ON public.emprestimo FOR EACH ROW WHEN ((new.data_entrega IS NOT NULL)) EXECUTE FUNCTION public.alertatraso();
 9   DROP TRIGGER trigger_alerta_atraso ON public.emprestimo;
       public          postgres    false    234    223    223            �           2606    16463 %   emprestimo emprestimo_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.emprestimo
    ADD CONSTRAINT emprestimo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);
 O   ALTER TABLE ONLY public.emprestimo DROP CONSTRAINT emprestimo_id_usuario_fkey;
       public          postgres    false    223    3227    221            �           2606    16472    telefone fk_telefone_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT fk_telefone_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);
 F   ALTER TABLE ONLY public.telefone DROP CONSTRAINT fk_telefone_usuario;
       public          postgres    false    219    3227    221            �           2606    16494    livro livro_id_autor_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.livro
    ADD CONSTRAINT livro_id_autor_fkey FOREIGN KEY (id_autor) REFERENCES public.autor(id);
 C   ALTER TABLE ONLY public.livro DROP CONSTRAINT livro_id_autor_fkey;
       public          postgres    false    3219    215    225            �           2606    16499    livro livro_id_editora_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.livro
    ADD CONSTRAINT livro_id_editora_fkey FOREIGN KEY (id_editora) REFERENCES public.editora(id);
 E   ALTER TABLE ONLY public.livro DROP CONSTRAINT livro_id_editora_fkey;
       public          postgres    false    217    3221    225            5   U   x�3��)M)�LW(��S��,N-�2����/ɨTpK-*�,.�2����M,V��N-)��2�tI��L�Q�N��K�M������ �6�      7   0   x�3�H,�,*-�2��ON��2�t�H,�M�2�t,I�K����� �T
�      =   a   x����� C��.TI �.�	��V��QA�E~~r��5����ҧB	�_M>k<ל�ղ4Hd��͸����q��n=Ct�?<�y$��p,�����?�      ?   �   x��1
�@�z�s���M"�����f�EL6d��XyO�������M�%���~!��'�X�+�v�ԧ.�%����a�p�>C�%
Ԇ��m\S��L�4v�n�N��6�b1UY�]�ikC|ڣ:�Գ�xY ���&      9   B   x�ʱ�0��&�DS�v��s$���������b^
̩݆�c
hy�Jס���ޕ%l��8*h      ;   q   x�3�J�L�KU��)K�,s�s3s���s9��Lt�t-��9�Ss�2K��2�9���M8�sr�S�2��8�2ӱ+4��M,�LTp�ɬJ����+����� �f3V     