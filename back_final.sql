PGDMP     (        	            y            restorebase    9.6.21    10.15 ,    ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            ?           1262    16496    restorebase    DATABASE     ?   CREATE DATABASE restorebase WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Spain.1252' LC_CTYPE = 'Spanish_Spain.1252';
    DROP DATABASE restorebase;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            ?           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12387    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            ?           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            ?            1259    16497    planilla    TABLE     ?   CREATE TABLE public.planilla (
    nombre character varying,
    nid integer,
    salario integer,
    codigoempresa integer
);
    DROP TABLE public.planilla;
       public         postgres    false    3            ?            1255    16503    buscarinfo(integer)    FUNCTION     ?   CREATE FUNCTION public.buscarinfo(integer) RETURNS public.planilla
    LANGUAGE sql
    AS $_$
select * from planilla where nid=$1
$_$;
 *   DROP FUNCTION public.buscarinfo(integer);
       public       postgres    false    3    185            ?            1255    16504     buscarsalario(character varying)    FUNCTION     ?   CREATE FUNCTION public.buscarsalario(character varying) RETURNS integer
    LANGUAGE sql
    AS $_$
select salario from planilla
where nombre = $1
$_$;
 7   DROP FUNCTION public.buscarsalario(character varying);
       public       postgres    false    3            ?            1255    16505    insertarpersonas()    FUNCTION     4  CREATE FUNCTION public.insertarpersonas() RETURNS void
    LANGUAGE sql
    AS $$
insert into planilla values('Hugo','1235','1000','1');
insert into planilla values('Luis','1234','1200','1');
insert into planilla values('German','1222','1100','2');
insert into planilla values('Olga','1234','1000','2');
$$;
 )   DROP FUNCTION public.insertarpersonas();
       public       postgres    false    3            ?            1255    16506 	   sp_test()    FUNCTION     ?   CREATE FUNCTION public.sp_test() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin

insert into "logs_planilla" values(old.nombre, old.nid, old.salario, old.codigoempresa);
return new;

end
$$;
     DROP FUNCTION public.sp_test();
       public       postgres    false    3    1            ?            1255    16507    sp_tr_insert()    FUNCTION     K  CREATE FUNCTION public.sp_tr_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare 

usuario varchar(50) := User;
fecha date := current_date;
tiempo timestamp := current_timestamp;

begin
insert into "logs_planilla" values(new.nombre, new.nid, new.salario, new.codigoempresa, usuario, fecha, tiempo);
return new;
end
$$;
 %   DROP FUNCTION public.sp_tr_insert();
       public       postgres    false    1    3            ?            1255    16508    suma(integer, integer)    FUNCTION     {   CREATE FUNCTION public.suma(num1 integer, num2 integer) RETURNS integer
    LANGUAGE sql
    AS $$
select num1 + num2;
$$;
 7   DROP FUNCTION public.suma(num1 integer, num2 integer);
       public       postgres    false    3            ?            1259    16509    empresas    TABLE     m   CREATE TABLE public.empresas (
    id_empresa integer NOT NULL,
    nombre_empresa character(40) NOT NULL
);
    DROP TABLE public.empresas;
       public         postgres    false    3            ?            1259    16512    logs_planilla    TABLE     ?   CREATE TABLE public.logs_planilla (
    nombre character(60),
    nid integer,
    salario integer,
    codigoempresa integer,
    usuario character(50),
    fecha date,
    tiempo timestamp without time zone
);
 !   DROP TABLE public.logs_planilla;
       public         postgres    false    3            ?            1259    16515    persona    TABLE     ?   CREATE TABLE public.persona (
    idpersona integer NOT NULL,
    nombre character varying(20),
    cedula character varying(10),
    test character varying(21)
);
    DROP TABLE public.persona;
       public         postgres    false    3            ?            1259    16518    personatestayudante    TABLE     y   CREATE TABLE public.personatestayudante (
    idpersona integer NOT NULL,
    nombre character varying(20)[] NOT NULL
);
 '   DROP TABLE public.personatestayudante;
       public         postgres    false    3            ?            1259    16524    planilla_salarios_max    TABLE     ]   CREATE TABLE public.planilla_salarios_max (
    nombre character(50),
    salario integer
);
 )   DROP TABLE public.planilla_salarios_max;
       public         postgres    false    3            ?            1259    16527 
   sec_indice    SEQUENCE     u   CREATE SEQUENCE public.sec_indice
    START WITH 1
    INCREMENT BY 30
    NO MINVALUE
    MAXVALUE 100
    CACHE 1;
 !   DROP SEQUENCE public.sec_indice;
       public       postgres    false    3            ?            1259    16529    test    TABLE     ?   CREATE TABLE public.test (
    idtest integer NOT NULL,
    nombre character varying(20),
    telefono character varying(11) DEFAULT 'Desconocido'::character varying
);
    DROP TABLE public.test;
       public         postgres    false    3            ?            1259    16533    test_idtest_seq    SEQUENCE     x   CREATE SEQUENCE public.test_idtest_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.test_idtest_seq;
       public       postgres    false    3    192            ?           0    0    test_idtest_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.test_idtest_seq OWNED BY public.test.idtest;
            public       postgres    false    193            ?            1259    16535    view_datafrompersona    VIEW     n   CREATE VIEW public.view_datafrompersona AS
 SELECT planilla.nombre,
    planilla.nid
   FROM public.planilla;
 '   DROP VIEW public.view_datafrompersona;
       public       postgres    false    185    185    3            ?            1259    16539    view_persona    VIEW     ?   CREATE VIEW public.view_persona AS
 SELECT persona.idpersona,
    persona.nombre,
    persona.cedula,
    persona.test
   FROM public.persona
  WHERE ((persona.nombre)::text = 'Hugo'::text);
    DROP VIEW public.view_persona;
       public       postgres    false    188    188    188    188    3            ?            1259    16543    view_persona1    VIEW     ?   CREATE VIEW public.view_persona1 AS
 SELECT persona.idpersona,
    persona.nombre,
    persona.cedula,
    persona.test
   FROM public.persona
  WHERE ((persona.nombre)::text = 'Hugo'::text)
  WITH CASCADED CHECK OPTION;
     DROP VIEW public.view_persona1;
       public       postgres    false    188    188    188    188    3            ?            1259    16547 
   view_union    VIEW       CREATE VIEW public.view_union AS
 SELECT planilla.nombre,
    planilla.nid,
    'Planilla'::text AS origen
   FROM public.planilla
UNION ALL
 SELECT persona.nombre,
    persona.idpersona AS nid,
    'Persona'::text AS origen
   FROM public.persona
  ORDER BY 3;
    DROP VIEW public.view_union;
       public       postgres    false    185    185    188    188    3                       2604    16551    test idtest    DEFAULT     j   ALTER TABLE ONLY public.test ALTER COLUMN idtest SET DEFAULT nextval('public.test_idtest_seq'::regclass);
 :   ALTER TABLE public.test ALTER COLUMN idtest DROP DEFAULT;
       public       postgres    false    193    192            ?          0    16509    empresas 
   TABLE DATA               >   COPY public.empresas (id_empresa, nombre_empresa) FROM stdin;
    public       postgres    false    186   ?0       ?          0    16512    logs_planilla 
   TABLE DATA               d   COPY public.logs_planilla (nombre, nid, salario, codigoempresa, usuario, fecha, tiempo) FROM stdin;
    public       postgres    false    187   1       ?          0    16515    persona 
   TABLE DATA               B   COPY public.persona (idpersona, nombre, cedula, test) FROM stdin;
    public       postgres    false    188   ?1       ?          0    16518    personatestayudante 
   TABLE DATA               @   COPY public.personatestayudante (idpersona, nombre) FROM stdin;
    public       postgres    false    189   2       ?          0    16497    planilla 
   TABLE DATA               G   COPY public.planilla (nombre, nid, salario, codigoempresa) FROM stdin;
    public       postgres    false    185   12       ?          0    16524    planilla_salarios_max 
   TABLE DATA               @   COPY public.planilla_salarios_max (nombre, salario) FROM stdin;
    public       postgres    false    190   ?2       ?          0    16529    test 
   TABLE DATA               8   COPY public.test (idtest, nombre, telefono) FROM stdin;
    public       postgres    false    192   ?2       ?           0    0 
   sec_indice    SEQUENCE SET     :   SELECT pg_catalog.setval('public.sec_indice', 100, true);
            public       postgres    false    191            ?           0    0    test_idtest_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.test_idtest_seq', 2, true);
            public       postgres    false    193                       2606    16553    empresas empresas_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.empresas
    ADD CONSTRAINT empresas_pkey PRIMARY KEY (id_empresa);
 @   ALTER TABLE ONLY public.empresas DROP CONSTRAINT empresas_pkey;
       public         postgres    false    186                       2606    16555    persona persona_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (idpersona);
 >   ALTER TABLE ONLY public.persona DROP CONSTRAINT persona_pkey;
       public         postgres    false    188            
           2606    16557    test test_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (idtest);
 8   ALTER TABLE ONLY public.test DROP CONSTRAINT test_pkey;
       public         postgres    false    192                       2620    16558    planilla tr_insert    TRIGGER     o   CREATE TRIGGER tr_insert AFTER INSERT ON public.planilla FOR EACH ROW EXECUTE PROCEDURE public.sp_tr_insert();
 +   DROP TRIGGER tr_insert ON public.planilla;
       public       postgres    false    202    185                       2620    16559    planilla tr_update    TRIGGER     k   CREATE TRIGGER tr_update BEFORE UPDATE ON public.planilla FOR EACH ROW EXECUTE PROCEDURE public.sp_test();
 +   DROP TRIGGER tr_update ON public.planilla;
       public       postgres    false    185    201                       2606    16560    planilla fktest    FK CONSTRAINT        ALTER TABLE ONLY public.planilla
    ADD CONSTRAINT fktest FOREIGN KEY (codigoempresa) REFERENCES public.empresas(id_empresa);
 9   ALTER TABLE ONLY public.planilla DROP CONSTRAINT fktest;
       public       postgres    false    2054    185    186            ?   0   x?3?t?L??(NT ??8ӋR?	?T?2??(M??????1z\\\ S??      ?   ?   x??(M?W pr? ???ʠ?8cj?f???D ??4#?qF???%?E??$?5202?50?52Eb*?[?[?????Xr?$???:,??)?$????? 	T=(?#cS?QݘY?Z?A???9??V????5B3?
?aL??<????g??,F??? ???      ?   :   x?3??(M??4040420????I?2?tI??L?1?4226???@???=... ??      ?      x?????? ? ?      ?   \   x???IO?4426?4400?4??(M?/???s)#E??Ӑ?b?Oif1?#??!XH?&??Y?Z???;??V$r??1z\\\ |$`      ?       x?3R pq???????+F??? ??1      ?   '   x?3??(M??4626?2??]R??????3S??b???? ?g	?     