PGDMP      9        	        |            FINAL FAFSAFAS    16.2    16.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    59247    FINAL FAFSAFAS    DATABASE     �   CREATE DATABASE "FINAL FAFSAFAS" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
     DROP DATABASE "FINAL FAFSAFAS";
                postgres    false            �           1247    59455    cargo_domain    DOMAIN     Q  CREATE DOMAIN public.cargo_domain AS character varying(50)
	CONSTRAINT cargo_domain_check CHECK (((VALUE)::text = ANY ((ARRAY['vendedor'::character varying, 'gerente de ventas'::character varying, 'soporte tecnico'::character varying, 'administrador de agencia'::character varying, 'servicio al cliente'::character varying])::text[])));
 !   DROP DOMAIN public.cargo_domain;
       public          postgres    false            �           1247    59267    correo_domain    DOMAIN     �   CREATE DOMAIN public.correo_domain AS character varying(50)
	CONSTRAINT correo_domain_check CHECK (((VALUE)::text ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'::text));
 "   DROP DOMAIN public.correo_domain;
       public          postgres    false            �           1247    59410    estado_contacto    DOMAIN     �   CREATE DOMAIN public.estado_contacto AS character varying(30)
	CONSTRAINT estado_contacto_check CHECK (((VALUE)::text = ANY ((ARRAY['Iniciado'::character varying, 'Culminado'::character varying, 'Pendiente'::character varying])::text[])));
 $   DROP DOMAIN public.estado_contacto;
       public          postgres    false            �           1247    59307    estado_linea_domain    DOMAIN     �   CREATE DOMAIN public.estado_linea_domain AS character varying(10)
	CONSTRAINT estado_linea_domain_check CHECK (((VALUE)::text = ANY ((ARRAY['Activo'::character varying, 'Suspendido'::character varying, 'Cancelado'::character varying])::text[])));
 (   DROP DOMAIN public.estado_linea_domain;
       public          postgres    false            �           1247    59264    estadoc_domain    DOMAIN       CREATE DOMAIN public.estadoc_domain AS character varying(10)
	CONSTRAINT estadoc_domain_check CHECK (((VALUE)::text = ANY ((ARRAY['Soltero'::character varying, 'Casado'::character varying, 'Divorciado'::character varying, 'Viudo'::character varying])::text[])));
 #   DROP DOMAIN public.estadoc_domain;
       public          postgres    false            �           1247    59413    motivo_contacto    DOMAIN     *  CREATE DOMAIN public.motivo_contacto AS character varying(30)
	CONSTRAINT motivo_contacto_check CHECK (((VALUE)::text = ANY ((ARRAY['Consulta de planes'::character varying, 'Reclamos'::character varying, 'Compra de planes'::character varying, 'Compra de productos'::character varying])::text[])));
 $   DROP DOMAIN public.motivo_contacto;
       public          postgres    false            �           1247    59353    precio_positivo_dos_deci    DOMAIN     �   CREATE DOMAIN public.precio_positivo_dos_deci AS numeric(10,2)
	CONSTRAINT precio_positivo_dos_deci_check CHECK ((VALUE >= (0)::numeric));
 -   DROP DOMAIN public.precio_positivo_dos_deci;
       public          postgres    false            �           1247    59441    razon_social_domain    DOMAIN     z  CREATE DOMAIN public.razon_social_domain AS character varying(10)
	CONSTRAINT razon_social_domain_check CHECK (((VALUE)::text = ANY ((ARRAY['S.A.'::character varying, 'C.A.'::character varying, 'S.A.C.A'::character varying, 'S.A.I.C.A'::character varying, 'S.R.L.'::character varying, 'R.L.'::character varying, 'R.S.'::character varying, 'F.P'::character varying])::text[])));
 (   DROP DOMAIN public.razon_social_domain;
       public          postgres    false            }           1247    59261    sexo_domain    DOMAIN     �   CREATE DOMAIN public.sexo_domain AS character varying(10)
	CONSTRAINT sexo_domain_check CHECK (((VALUE)::text = ANY ((ARRAY['hombre'::character varying, 'mujer'::character varying, 'otro'::character varying])::text[])));
     DROP DOMAIN public.sexo_domain;
       public          postgres    false            �           1247    59304    tecnologia_domain    DOMAIN     �   CREATE DOMAIN public.tecnologia_domain AS character varying(5)
	CONSTRAINT tecnologia_domain_check CHECK (((VALUE)::text = ANY ((ARRAY['GSM'::character varying, 'LTE'::character varying, '3G'::character varying])::text[])));
 &   DROP DOMAIN public.tecnologia_domain;
       public          postgres    false            �           1247    59270 
   tlf_domain    DOMAIN     �   CREATE DOMAIN public.tlf_domain AS character varying(11)
	CONSTRAINT tlf_domain_check CHECK (((VALUE)::text ~* '[0-9]'::text));
    DROP DOMAIN public.tlf_domain;
       public          postgres    false            v           1247    59249    website_domain    DOMAIN     �   CREATE DOMAIN public.website_domain AS character varying(50)
	CONSTRAINT website_domain_check CHECK (((VALUE)::text ~* '^((https?|ftp|smtp):\/\/)?(www.)?[a-z0-9]+\.[a-z]+(\/[a-zA-Z0-9#]+\/?)*$'::text));
 #   DROP DOMAIN public.website_domain;
       public          postgres    false                       1255    59381    actualizar_num_subplanes()    FUNCTION     +  CREATE FUNCTION public.actualizar_num_subplanes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  UPDATE Plan
  SET num_subplanes= (
      SELECT COUNT(*)
      FROM Subplan
      WHERE Subplan.id_producto = NEW.id_producto)
  WHERE Plan.id_producto = NEW.id_producto;
  RETURN NEW;
END;
$$;
 1   DROP FUNCTION public.actualizar_num_subplanes();
       public          postgres    false                       1255    59546    actualizar_numero_adscritos()    FUNCTION     >  CREATE FUNCTION public.actualizar_numero_adscritos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  UPDATE Subplan
  SET num_clientes_adscritos= (
      SELECT COUNT(*)
      FROM Contiene
      WHERE Contiene.id_subplan = NEW.id_subplan
  )
  WHERE Subplan.id_subplan = NEW.id_subplan;
  RETURN NEW;
END;
$$;
 4   DROP FUNCTION public.actualizar_numero_adscritos();
       public          postgres    false                       1255    59550    actualizar_numero_empleados()    FUNCTION     <  CREATE FUNCTION public.actualizar_numero_empleados() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  UPDATE AgenteAutorizado
  SET numero_empleados = (
      SELECT COUNT(*)
      FROM Trabaja
      WHERE Trabaja.rif_agente = NEW.rif_agente
  )
  WHERE NEW.rif_agente = NEW.rif_agente;
  RETURN NEW;
END;
$$;
 4   DROP FUNCTION public.actualizar_numero_empleados();
       public          postgres    false                       1255    59548    actualizar_numero_ventas()    FUNCTION     �  CREATE FUNCTION public.actualizar_numero_ventas() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  UPDATE Trabaja
  SET numero_ventas_realizadas= (
      SELECT COUNT(*)
      FROM Contacta
      WHERE Contacta.id_empleado = id_persona AND Contacta.motivo_contacto IN ('Compra de planes', 'Compra de productos')
  )
  WHERE Trabaja.id_persona = id_persona;
  RETURN NEW;
END;
$$;
 1   DROP FUNCTION public.actualizar_numero_ventas();
       public          postgres    false                       1255    59552    actualizar_total_compra()    FUNCTION     -  CREATE FUNCTION public.actualizar_total_compra() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.id_equipo IS NOT NULL THEN
        UPDATE Compra
        SET total = NEW.cantidad * (SELECT precio FROM EquipoTelefonico WHERE id_producto = NEW.id_equipo)
        WHERE Compra.id_compra = NEW.id_compra;
    ELSIF NEW.id_plan IS NOT NULL THEN
        UPDATE Compra
        SET total = NEW.cantidad * (SELECT precio FROM Plan WHERE id_producto = NEW.id_plan)
        WHERE Compra.id_compra = NEW.id_compra;
    END IF;

    RETURN NEW;
END;
$$;
 0   DROP FUNCTION public.actualizar_total_compra();
       public          postgres    false            �            1259    59444    agenteautorizado    TABLE     w  CREATE TABLE public.agenteautorizado (
    rif_agente integer NOT NULL,
    nit integer,
    nombre_comercial character varying(50),
    calle character varying(15),
    ciudad character varying(15),
    estado character varying(15),
    pais character varying(15),
    email public.correo_domain,
    numero_empleados integer,
    razon_social public.razon_social_domain
);
 $   DROP TABLE public.agenteautorizado;
       public         heap    postgres    false    956    901            �            1259    59443    agenteautorizado_rif_agente_seq    SEQUENCE     �   CREATE SEQUENCE public.agenteautorizado_rif_agente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.agenteautorizado_rif_agente_seq;
       public          postgres    false    242            �           0    0    agenteautorizado_rif_agente_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.agenteautorizado_rif_agente_seq OWNED BY public.agenteautorizado.rif_agente;
          public          postgres    false    241            �            1259    59274    cliente    TABLE     �  CREATE TABLE public.cliente (
    id_persona integer NOT NULL,
    id_empresa integer NOT NULL,
    representa_empresa boolean,
    trabaja_empresa boolean,
    nombre character varying(15),
    apellido character varying(15),
    sexo public.sexo_domain,
    fecha_nasc date,
    lugar_nasc character varying(20),
    casa character varying(15),
    calle character varying(15),
    ciudad character varying(15),
    estado character varying(15),
    estado_civil public.estadoc_domain,
    pais character varying(15),
    email public.correo_domain,
    num_hijos integer,
    nivel_educacion character varying(15),
    telefono public.tlf_domain,
    numero_dep integer,
    CONSTRAINT cliente_check CHECK ((NOT (representa_empresa AND trabaja_empresa)))
);
    DROP TABLE public.cliente;
       public         heap    postgres    false    905    893    897    901            �            1259    59273    cliente_id_empresa_seq    SEQUENCE     �   CREATE SEQUENCE public.cliente_id_empresa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cliente_id_empresa_seq;
       public          postgres    false    219            �           0    0    cliente_id_empresa_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.cliente_id_empresa_seq OWNED BY public.cliente.id_empresa;
          public          postgres    false    218            �            1259    59272    cliente_id_persona_seq    SEQUENCE     �   CREATE SEQUENCE public.cliente_id_persona_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cliente_id_persona_seq;
       public          postgres    false    219            �           0    0    cliente_id_persona_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.cliente_id_persona_seq OWNED BY public.cliente.id_persona;
          public          postgres    false    217            �            1259    59384    compra    TABLE     |  CREATE TABLE public.compra (
    id_compra integer NOT NULL,
    id_cliente integer NOT NULL,
    id_plan integer,
    id_equipo integer,
    cantidad integer,
    fecha_compra date,
    total public.precio_positivo_dos_deci,
    CONSTRAINT compra_check CHECK ((((id_plan IS NOT NULL) OR (id_equipo IS NOT NULL)) AND (NOT ((id_plan IS NOT NULL) AND (id_equipo IS NOT NULL)))))
);
    DROP TABLE public.compra;
       public         heap    postgres    false    932            �            1259    59383    compra_id_cliente_seq    SEQUENCE     �   CREATE SEQUENCE public.compra_id_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.compra_id_cliente_seq;
       public          postgres    false    237            �           0    0    compra_id_cliente_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.compra_id_cliente_seq OWNED BY public.compra.id_cliente;
          public          postgres    false    236            �            1259    59382    compra_id_compra_seq    SEQUENCE     �   CREATE SEQUENCE public.compra_id_compra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.compra_id_compra_seq;
       public          postgres    false    237            �           0    0    compra_id_compra_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.compra_id_compra_seq OWNED BY public.compra.id_compra;
          public          postgres    false    235            �            1259    59417    contacta    TABLE     [  CREATE TABLE public.contacta (
    id_cliente integer NOT NULL,
    id_empleado integer NOT NULL,
    id_compra integer,
    estado public.estado_contacto,
    fecha_atencion date,
    descripcion character varying(50),
    motivo_contacto public.motivo_contacto,
    CONSTRAINT contacta_check CHECK (((((motivo_contacto)::text = ANY ((ARRAY['Compra de planes'::character varying, 'Compra de productos'::character varying])::text[])) AND (id_compra IS NOT NULL)) OR ((motivo_contacto)::text <> ALL ((ARRAY['Compra de planes'::character varying, 'Compra de productos'::character varying])::text[]))))
);
    DROP TABLE public.contacta;
       public         heap    postgres    false    949    945            �            1259    59415    contacta_id_cliente_seq    SEQUENCE     �   CREATE SEQUENCE public.contacta_id_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.contacta_id_cliente_seq;
       public          postgres    false    240            �           0    0    contacta_id_cliente_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.contacta_id_cliente_seq OWNED BY public.contacta.id_cliente;
          public          postgres    false    238            �            1259    59416    contacta_id_empleado_seq    SEQUENCE     �   CREATE SEQUENCE public.contacta_id_empleado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.contacta_id_empleado_seq;
       public          postgres    false    240            �           0    0    contacta_id_empleado_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.contacta_id_empleado_seq OWNED BY public.contacta.id_empleado;
          public          postgres    false    239                        1259    59520    contiene    TABLE        CREATE TABLE public.contiene (
    id_linea integer NOT NULL,
    id_subplan integer NOT NULL,
    id_plan integer NOT NULL
);
    DROP TABLE public.contiene;
       public         heap    postgres    false            �            1259    59517    contiene_id_linea_seq    SEQUENCE     �   CREATE SEQUENCE public.contiene_id_linea_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.contiene_id_linea_seq;
       public          postgres    false    256            �           0    0    contiene_id_linea_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.contiene_id_linea_seq OWNED BY public.contiene.id_linea;
          public          postgres    false    253            �            1259    59519    contiene_id_plan_seq    SEQUENCE     �   CREATE SEQUENCE public.contiene_id_plan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.contiene_id_plan_seq;
       public          postgres    false    256            �           0    0    contiene_id_plan_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.contiene_id_plan_seq OWNED BY public.contiene.id_plan;
          public          postgres    false    255            �            1259    59518    contiene_id_subplan_seq    SEQUENCE     �   CREATE SEQUENCE public.contiene_id_subplan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.contiene_id_subplan_seq;
       public          postgres    false    256            �           0    0    contiene_id_subplan_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.contiene_id_subplan_seq OWNED BY public.contiene.id_subplan;
          public          postgres    false    254            �            1259    59326    distribuidor    TABLE     Q  CREATE TABLE public.distribuidor (
    rif_distribuidor integer NOT NULL,
    nit integer NOT NULL,
    num_casa character varying(15),
    calle character varying(15),
    ciudad character varying(15),
    estado character varying(15),
    pais character varying(15),
    nombre character varying(15),
    telefono public.tlf_domain
);
     DROP TABLE public.distribuidor;
       public         heap    postgres    false    905            �            1259    59325 !   distribuidor_rif_distribuidor_seq    SEQUENCE     �   CREATE SEQUENCE public.distribuidor_rif_distribuidor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.distribuidor_rif_distribuidor_seq;
       public          postgres    false    226            �           0    0 !   distribuidor_rif_distribuidor_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.distribuidor_rif_distribuidor_seq OWNED BY public.distribuidor.rif_distribuidor;
          public          postgres    false    225            �            1259    59293    empleado    TABLE     �  CREATE TABLE public.empleado (
    id_persona integer NOT NULL,
    nombre character varying(15),
    apellido character varying(15),
    sexo public.sexo_domain,
    fecha_nasc date,
    lugar_nasc character varying(20),
    casa character varying(15),
    calle character varying(15),
    ciudad character varying(15),
    estado character varying(15),
    estado_civil public.estadoc_domain,
    pais character varying(15),
    email public.correo_domain,
    seguridad_social integer
);
    DROP TABLE public.empleado;
       public         heap    postgres    false    897    901    893            �            1259    59292    empleado_id_persona_seq    SEQUENCE     �   CREATE SEQUENCE public.empleado_id_persona_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.empleado_id_persona_seq;
       public          postgres    false    221            �           0    0    empleado_id_persona_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.empleado_id_persona_seq OWNED BY public.empleado.id_persona;
          public          postgres    false    220            �            1259    59252    empresa    TABLE     &  CREATE TABLE public.empresa (
    id_empresa integer NOT NULL,
    nombre character varying(15),
    calle character varying(15),
    ciudad character varying(15),
    estado character varying(15),
    pais character varying(15),
    website public.website_domain,
    num_empleados integer
);
    DROP TABLE public.empresa;
       public         heap    postgres    false    886            �            1259    59251    empresa_id_empresa_seq    SEQUENCE     �   CREATE SEQUENCE public.empresa_id_empresa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.empresa_id_empresa_seq;
       public          postgres    false    216            �           0    0    empresa_id_empresa_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.empresa_id_empresa_seq OWNED BY public.empresa.id_empresa;
          public          postgres    false    215            �            1259    59357    equipotelefonico    TABLE     V  CREATE TABLE public.equipotelefonico (
    id_producto integer NOT NULL,
    id_fabricante integer NOT NULL,
    precio public.precio_positivo_dos_deci,
    nombre character varying(25),
    modelo character varying(25),
    garantia character varying(25),
    imagen_producto character varying(100),
    descripcion character varying(25)
);
 $   DROP TABLE public.equipotelefonico;
       public         heap    postgres    false    932            �            1259    59356 "   equipotelefonico_id_fabricante_seq    SEQUENCE     �   CREATE SEQUENCE public.equipotelefonico_id_fabricante_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.equipotelefonico_id_fabricante_seq;
       public          postgres    false    232            �           0    0 "   equipotelefonico_id_fabricante_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.equipotelefonico_id_fabricante_seq OWNED BY public.equipotelefonico.id_fabricante;
          public          postgres    false    231            �            1259    59355     equipotelefonico_id_producto_seq    SEQUENCE     �   CREATE SEQUENCE public.equipotelefonico_id_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.equipotelefonico_id_producto_seq;
       public          postgres    false    232            �           0    0     equipotelefonico_id_producto_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.equipotelefonico_id_producto_seq OWNED BY public.equipotelefonico.id_producto;
          public          postgres    false    230            �            1259    59336 
   fabricante    TABLE     �  CREATE TABLE public.fabricante (
    id_fabricante integer NOT NULL,
    rif_distribuidor integer NOT NULL,
    calle character varying(15),
    cuidad character varying(15),
    estado character varying(15),
    pais character varying(15),
    "nombre_compa¤ia" character varying(20),
    telefono public.tlf_domain,
    pagina_web public.website_domain,
    email public.correo_domain
);
    DROP TABLE public.fabricante;
       public         heap    postgres    false    905    901    886            �            1259    59334    fabricante_id_fabricante_seq    SEQUENCE     �   CREATE SEQUENCE public.fabricante_id_fabricante_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.fabricante_id_fabricante_seq;
       public          postgres    false    229            �           0    0    fabricante_id_fabricante_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.fabricante_id_fabricante_seq OWNED BY public.fabricante.id_fabricante;
          public          postgres    false    227            �            1259    59335    fabricante_rif_distribuidor_seq    SEQUENCE     �   CREATE SEQUENCE public.fabricante_rif_distribuidor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.fabricante_rif_distribuidor_seq;
       public          postgres    false    229            �           0    0    fabricante_rif_distribuidor_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.fabricante_rif_distribuidor_seq OWNED BY public.fabricante.rif_distribuidor;
          public          postgres    false    228            �            1259    59311    lineatelefonica    TABLE     �   CREATE TABLE public.lineatelefonica (
    id_linea integer NOT NULL,
    id_cliente integer NOT NULL,
    tecnologia public.tecnologia_domain,
    estado_linea public.estado_linea_domain,
    numero_linea public.tlf_domain
);
 #   DROP TABLE public.lineatelefonica;
       public         heap    postgres    false    905    915    919            �            1259    59310    lineatelefonica_id_cliente_seq    SEQUENCE     �   CREATE SEQUENCE public.lineatelefonica_id_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.lineatelefonica_id_cliente_seq;
       public          postgres    false    224            �           0    0    lineatelefonica_id_cliente_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.lineatelefonica_id_cliente_seq OWNED BY public.lineatelefonica.id_cliente;
          public          postgres    false    223            �            1259    59309    lineatelefonica_id_linea_seq    SEQUENCE     �   CREATE SEQUENCE public.lineatelefonica_id_linea_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.lineatelefonica_id_linea_seq;
       public          postgres    false    224            �           0    0    lineatelefonica_id_linea_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.lineatelefonica_id_linea_seq OWNED BY public.lineatelefonica.id_linea;
          public          postgres    false    222            �            1259    59372    plan    TABLE     K  CREATE TABLE public.plan (
    id_producto integer NOT NULL,
    precio public.precio_positivo_dos_deci,
    nombre character varying(15),
    num_subplanes integer,
    es_mensajeria boolean,
    es_llamada boolean,
    es_navegacion boolean,
    mensajes_permitidos integer,
    costo_minuto public.precio_positivo_dos_deci,
    velocidad_nav integer,
    CONSTRAINT plan_check CHECK ((((es_mensajeria IS NOT NULL) AND (mensajes_permitidos IS NOT NULL)) OR ((es_llamada IS NOT NULL) AND (costo_minuto IS NOT NULL)) OR ((es_navegacion IS NOT NULL) AND (velocidad_nav IS NOT NULL))))
);
    DROP TABLE public.plan;
       public         heap    postgres    false    932    932            �            1259    59371    plan_id_producto_seq    SEQUENCE     �   CREATE SEQUENCE public.plan_id_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.plan_id_producto_seq;
       public          postgres    false    234            �           0    0    plan_id_producto_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.plan_id_producto_seq OWNED BY public.plan.id_producto;
          public          postgres    false    233            �            1259    59475    subplan    TABLE     �   CREATE TABLE public.subplan (
    id_subplan integer NOT NULL,
    id_producto integer NOT NULL,
    num_clientes_adscritos integer,
    tarifa public.precio_positivo_dos_deci,
    nombre character varying(15),
    descripcion character varying(200)
);
    DROP TABLE public.subplan;
       public         heap    postgres    false    932            �            1259    59474    subplan_id_producto_seq    SEQUENCE     �   CREATE SEQUENCE public.subplan_id_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.subplan_id_producto_seq;
       public          postgres    false    248            �           0    0    subplan_id_producto_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.subplan_id_producto_seq OWNED BY public.subplan.id_producto;
          public          postgres    false    247            �            1259    59473    subplan_id_subplan_seq    SEQUENCE     �   CREATE SEQUENCE public.subplan_id_subplan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.subplan_id_subplan_seq;
       public          postgres    false    248            �           0    0    subplan_id_subplan_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.subplan_id_subplan_seq OWNED BY public.subplan.id_subplan;
          public          postgres    false    246            �            1259    59490    telefonoagenteautorizado    TABLE     {   CREATE TABLE public.telefonoagenteautorizado (
    telefono public.tlf_domain NOT NULL,
    rif_agente integer NOT NULL
);
 ,   DROP TABLE public.telefonoagenteautorizado;
       public         heap    postgres    false    905            �            1259    59489 '   telefonoagenteautorizado_rif_agente_seq    SEQUENCE     �   CREATE SEQUENCE public.telefonoagenteautorizado_rif_agente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.telefonoagenteautorizado_rif_agente_seq;
       public          postgres    false    250            �           0    0 '   telefonoagenteautorizado_rif_agente_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public.telefonoagenteautorizado_rif_agente_seq OWNED BY public.telefonoagenteautorizado.rif_agente;
          public          postgres    false    249            �            1259    59504    telefonoempresa    TABLE     r   CREATE TABLE public.telefonoempresa (
    telefono public.tlf_domain NOT NULL,
    id_empresa integer NOT NULL
);
 #   DROP TABLE public.telefonoempresa;
       public         heap    postgres    false    905            �            1259    59503    telefonoempresa_id_empresa_seq    SEQUENCE     �   CREATE SEQUENCE public.telefonoempresa_id_empresa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.telefonoempresa_id_empresa_seq;
       public          postgres    false    252            �           0    0    telefonoempresa_id_empresa_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.telefonoempresa_id_empresa_seq OWNED BY public.telefonoempresa.id_empresa;
          public          postgres    false    251            �            1259    59459    trabaja    TABLE     �   CREATE TABLE public.trabaja (
    id_persona integer NOT NULL,
    rif_agente integer NOT NULL,
    sueldo public.precio_positivo_dos_deci NOT NULL,
    cargo public.cargo_domain,
    fecha_contratacion date,
    numero_ventas_realizadas integer
);
    DROP TABLE public.trabaja;
       public         heap    postgres    false    963    932            �            1259    59457    trabaja_id_persona_seq    SEQUENCE     �   CREATE SEQUENCE public.trabaja_id_persona_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.trabaja_id_persona_seq;
       public          postgres    false    245            �           0    0    trabaja_id_persona_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.trabaja_id_persona_seq OWNED BY public.trabaja.id_persona;
          public          postgres    false    243            �            1259    59458    trabaja_rif_agente_seq    SEQUENCE     �   CREATE SEQUENCE public.trabaja_rif_agente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.trabaja_rif_agente_seq;
       public          postgres    false    245            �           0    0    trabaja_rif_agente_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.trabaja_rif_agente_seq OWNED BY public.trabaja.rif_agente;
          public          postgres    false    244            �           2604    59447    agenteautorizado rif_agente    DEFAULT     �   ALTER TABLE ONLY public.agenteautorizado ALTER COLUMN rif_agente SET DEFAULT nextval('public.agenteautorizado_rif_agente_seq'::regclass);
 J   ALTER TABLE public.agenteautorizado ALTER COLUMN rif_agente DROP DEFAULT;
       public          postgres    false    241    242    242            �           2604    59277    cliente id_persona    DEFAULT     x   ALTER TABLE ONLY public.cliente ALTER COLUMN id_persona SET DEFAULT nextval('public.cliente_id_persona_seq'::regclass);
 A   ALTER TABLE public.cliente ALTER COLUMN id_persona DROP DEFAULT;
       public          postgres    false    217    219    219            �           2604    59278    cliente id_empresa    DEFAULT     x   ALTER TABLE ONLY public.cliente ALTER COLUMN id_empresa SET DEFAULT nextval('public.cliente_id_empresa_seq'::regclass);
 A   ALTER TABLE public.cliente ALTER COLUMN id_empresa DROP DEFAULT;
       public          postgres    false    218    219    219            �           2604    59387    compra id_compra    DEFAULT     t   ALTER TABLE ONLY public.compra ALTER COLUMN id_compra SET DEFAULT nextval('public.compra_id_compra_seq'::regclass);
 ?   ALTER TABLE public.compra ALTER COLUMN id_compra DROP DEFAULT;
       public          postgres    false    235    237    237            �           2604    59388    compra id_cliente    DEFAULT     v   ALTER TABLE ONLY public.compra ALTER COLUMN id_cliente SET DEFAULT nextval('public.compra_id_cliente_seq'::regclass);
 @   ALTER TABLE public.compra ALTER COLUMN id_cliente DROP DEFAULT;
       public          postgres    false    236    237    237            �           2604    59420    contacta id_cliente    DEFAULT     z   ALTER TABLE ONLY public.contacta ALTER COLUMN id_cliente SET DEFAULT nextval('public.contacta_id_cliente_seq'::regclass);
 B   ALTER TABLE public.contacta ALTER COLUMN id_cliente DROP DEFAULT;
       public          postgres    false    240    238    240            �           2604    59421    contacta id_empleado    DEFAULT     |   ALTER TABLE ONLY public.contacta ALTER COLUMN id_empleado SET DEFAULT nextval('public.contacta_id_empleado_seq'::regclass);
 C   ALTER TABLE public.contacta ALTER COLUMN id_empleado DROP DEFAULT;
       public          postgres    false    239    240    240            �           2604    59523    contiene id_linea    DEFAULT     v   ALTER TABLE ONLY public.contiene ALTER COLUMN id_linea SET DEFAULT nextval('public.contiene_id_linea_seq'::regclass);
 @   ALTER TABLE public.contiene ALTER COLUMN id_linea DROP DEFAULT;
       public          postgres    false    256    253    256            �           2604    59524    contiene id_subplan    DEFAULT     z   ALTER TABLE ONLY public.contiene ALTER COLUMN id_subplan SET DEFAULT nextval('public.contiene_id_subplan_seq'::regclass);
 B   ALTER TABLE public.contiene ALTER COLUMN id_subplan DROP DEFAULT;
       public          postgres    false    254    256    256            �           2604    59525    contiene id_plan    DEFAULT     t   ALTER TABLE ONLY public.contiene ALTER COLUMN id_plan SET DEFAULT nextval('public.contiene_id_plan_seq'::regclass);
 ?   ALTER TABLE public.contiene ALTER COLUMN id_plan DROP DEFAULT;
       public          postgres    false    256    255    256            �           2604    59329    distribuidor rif_distribuidor    DEFAULT     �   ALTER TABLE ONLY public.distribuidor ALTER COLUMN rif_distribuidor SET DEFAULT nextval('public.distribuidor_rif_distribuidor_seq'::regclass);
 L   ALTER TABLE public.distribuidor ALTER COLUMN rif_distribuidor DROP DEFAULT;
       public          postgres    false    225    226    226            �           2604    59296    empleado id_persona    DEFAULT     z   ALTER TABLE ONLY public.empleado ALTER COLUMN id_persona SET DEFAULT nextval('public.empleado_id_persona_seq'::regclass);
 B   ALTER TABLE public.empleado ALTER COLUMN id_persona DROP DEFAULT;
       public          postgres    false    220    221    221            �           2604    59255    empresa id_empresa    DEFAULT     x   ALTER TABLE ONLY public.empresa ALTER COLUMN id_empresa SET DEFAULT nextval('public.empresa_id_empresa_seq'::regclass);
 A   ALTER TABLE public.empresa ALTER COLUMN id_empresa DROP DEFAULT;
       public          postgres    false    216    215    216            �           2604    59360    equipotelefonico id_producto    DEFAULT     �   ALTER TABLE ONLY public.equipotelefonico ALTER COLUMN id_producto SET DEFAULT nextval('public.equipotelefonico_id_producto_seq'::regclass);
 K   ALTER TABLE public.equipotelefonico ALTER COLUMN id_producto DROP DEFAULT;
       public          postgres    false    230    232    232            �           2604    59361    equipotelefonico id_fabricante    DEFAULT     �   ALTER TABLE ONLY public.equipotelefonico ALTER COLUMN id_fabricante SET DEFAULT nextval('public.equipotelefonico_id_fabricante_seq'::regclass);
 M   ALTER TABLE public.equipotelefonico ALTER COLUMN id_fabricante DROP DEFAULT;
       public          postgres    false    232    231    232            �           2604    59339    fabricante id_fabricante    DEFAULT     �   ALTER TABLE ONLY public.fabricante ALTER COLUMN id_fabricante SET DEFAULT nextval('public.fabricante_id_fabricante_seq'::regclass);
 G   ALTER TABLE public.fabricante ALTER COLUMN id_fabricante DROP DEFAULT;
       public          postgres    false    227    229    229            �           2604    59340    fabricante rif_distribuidor    DEFAULT     �   ALTER TABLE ONLY public.fabricante ALTER COLUMN rif_distribuidor SET DEFAULT nextval('public.fabricante_rif_distribuidor_seq'::regclass);
 J   ALTER TABLE public.fabricante ALTER COLUMN rif_distribuidor DROP DEFAULT;
       public          postgres    false    229    228    229            �           2604    59314    lineatelefonica id_linea    DEFAULT     �   ALTER TABLE ONLY public.lineatelefonica ALTER COLUMN id_linea SET DEFAULT nextval('public.lineatelefonica_id_linea_seq'::regclass);
 G   ALTER TABLE public.lineatelefonica ALTER COLUMN id_linea DROP DEFAULT;
       public          postgres    false    222    224    224            �           2604    59315    lineatelefonica id_cliente    DEFAULT     �   ALTER TABLE ONLY public.lineatelefonica ALTER COLUMN id_cliente SET DEFAULT nextval('public.lineatelefonica_id_cliente_seq'::regclass);
 I   ALTER TABLE public.lineatelefonica ALTER COLUMN id_cliente DROP DEFAULT;
       public          postgres    false    223    224    224            �           2604    59375    plan id_producto    DEFAULT     t   ALTER TABLE ONLY public.plan ALTER COLUMN id_producto SET DEFAULT nextval('public.plan_id_producto_seq'::regclass);
 ?   ALTER TABLE public.plan ALTER COLUMN id_producto DROP DEFAULT;
       public          postgres    false    233    234    234            �           2604    59478    subplan id_subplan    DEFAULT     x   ALTER TABLE ONLY public.subplan ALTER COLUMN id_subplan SET DEFAULT nextval('public.subplan_id_subplan_seq'::regclass);
 A   ALTER TABLE public.subplan ALTER COLUMN id_subplan DROP DEFAULT;
       public          postgres    false    246    248    248            �           2604    59479    subplan id_producto    DEFAULT     z   ALTER TABLE ONLY public.subplan ALTER COLUMN id_producto SET DEFAULT nextval('public.subplan_id_producto_seq'::regclass);
 B   ALTER TABLE public.subplan ALTER COLUMN id_producto DROP DEFAULT;
       public          postgres    false    247    248    248            �           2604    59493 #   telefonoagenteautorizado rif_agente    DEFAULT     �   ALTER TABLE ONLY public.telefonoagenteautorizado ALTER COLUMN rif_agente SET DEFAULT nextval('public.telefonoagenteautorizado_rif_agente_seq'::regclass);
 R   ALTER TABLE public.telefonoagenteautorizado ALTER COLUMN rif_agente DROP DEFAULT;
       public          postgres    false    249    250    250            �           2604    59507    telefonoempresa id_empresa    DEFAULT     �   ALTER TABLE ONLY public.telefonoempresa ALTER COLUMN id_empresa SET DEFAULT nextval('public.telefonoempresa_id_empresa_seq'::regclass);
 I   ALTER TABLE public.telefonoempresa ALTER COLUMN id_empresa DROP DEFAULT;
       public          postgres    false    251    252    252            �           2604    59462    trabaja id_persona    DEFAULT     x   ALTER TABLE ONLY public.trabaja ALTER COLUMN id_persona SET DEFAULT nextval('public.trabaja_id_persona_seq'::regclass);
 A   ALTER TABLE public.trabaja ALTER COLUMN id_persona DROP DEFAULT;
       public          postgres    false    243    245    245            �           2604    59463    trabaja rif_agente    DEFAULT     x   ALTER TABLE ONLY public.trabaja ALTER COLUMN rif_agente SET DEFAULT nextval('public.trabaja_rif_agente_seq'::regclass);
 A   ALTER TABLE public.trabaja ALTER COLUMN rif_agente DROP DEFAULT;
       public          postgres    false    244    245    245            �          0    59444    agenteautorizado 
   TABLE DATA           �   COPY public.agenteautorizado (rif_agente, nit, nombre_comercial, calle, ciudad, estado, pais, email, numero_empleados, razon_social) FROM stdin;
    public          postgres    false    242   �      �          0    59274    cliente 
   TABLE DATA           �   COPY public.cliente (id_persona, id_empresa, representa_empresa, trabaja_empresa, nombre, apellido, sexo, fecha_nasc, lugar_nasc, casa, calle, ciudad, estado, estado_civil, pais, email, num_hijos, nivel_educacion, telefono, numero_dep) FROM stdin;
    public          postgres    false    219   T
      �          0    59384    compra 
   TABLE DATA           j   COPY public.compra (id_compra, id_cliente, id_plan, id_equipo, cantidad, fecha_compra, total) FROM stdin;
    public          postgres    false    237   D      �          0    59417    contacta 
   TABLE DATA           |   COPY public.contacta (id_cliente, id_empleado, id_compra, estado, fecha_atencion, descripcion, motivo_contacto) FROM stdin;
    public          postgres    false    240   #      �          0    59520    contiene 
   TABLE DATA           A   COPY public.contiene (id_linea, id_subplan, id_plan) FROM stdin;
    public          postgres    false    256   B      �          0    59326    distribuidor 
   TABLE DATA           v   COPY public.distribuidor (rif_distribuidor, nit, num_casa, calle, ciudad, estado, pais, nombre, telefono) FROM stdin;
    public          postgres    false    226   �      �          0    59293    empleado 
   TABLE DATA           �   COPY public.empleado (id_persona, nombre, apellido, sexo, fecha_nasc, lugar_nasc, casa, calle, ciudad, estado, estado_civil, pais, email, seguridad_social) FROM stdin;
    public          postgres    false    221   �      �          0    59252    empresa 
   TABLE DATA           j   COPY public.empresa (id_empresa, nombre, calle, ciudad, estado, pais, website, num_empleados) FROM stdin;
    public          postgres    false    216   �      �          0    59357    equipotelefonico 
   TABLE DATA           �   COPY public.equipotelefonico (id_producto, id_fabricante, precio, nombre, modelo, garantia, imagen_producto, descripcion) FROM stdin;
    public          postgres    false    232   �      �          0    59336 
   fabricante 
   TABLE DATA           �   COPY public.fabricante (id_fabricante, rif_distribuidor, calle, cuidad, estado, pais, "nombre_compa¤ia", telefono, pagina_web, email) FROM stdin;
    public          postgres    false    229   l      �          0    59311    lineatelefonica 
   TABLE DATA           g   COPY public.lineatelefonica (id_linea, id_cliente, tecnologia, estado_linea, numero_linea) FROM stdin;
    public          postgres    false    224   %      �          0    59372    plan 
   TABLE DATA           �   COPY public.plan (id_producto, precio, nombre, num_subplanes, es_mensajeria, es_llamada, es_navegacion, mensajes_permitidos, costo_minuto, velocidad_nav) FROM stdin;
    public          postgres    false    234   ,      �          0    59475    subplan 
   TABLE DATA           o   COPY public.subplan (id_subplan, id_producto, num_clientes_adscritos, tarifa, nombre, descripcion) FROM stdin;
    public          postgres    false    248         �          0    59490    telefonoagenteautorizado 
   TABLE DATA           H   COPY public.telefonoagenteautorizado (telefono, rif_agente) FROM stdin;
    public          postgres    false    250   5      �          0    59504    telefonoempresa 
   TABLE DATA           ?   COPY public.telefonoempresa (telefono, id_empresa) FROM stdin;
    public          postgres    false    252   �      �          0    59459    trabaja 
   TABLE DATA           v   COPY public.trabaja (id_persona, rif_agente, sueldo, cargo, fecha_contratacion, numero_ventas_realizadas) FROM stdin;
    public          postgres    false    245   R      �           0    0    agenteautorizado_rif_agente_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.agenteautorizado_rif_agente_seq', 1, false);
          public          postgres    false    241            �           0    0    cliente_id_empresa_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.cliente_id_empresa_seq', 1, false);
          public          postgres    false    218            �           0    0    cliente_id_persona_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.cliente_id_persona_seq', 1, false);
          public          postgres    false    217            �           0    0    compra_id_cliente_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.compra_id_cliente_seq', 1, false);
          public          postgres    false    236            �           0    0    compra_id_compra_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.compra_id_compra_seq', 1, false);
          public          postgres    false    235            �           0    0    contacta_id_cliente_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.contacta_id_cliente_seq', 1, false);
          public          postgres    false    238            �           0    0    contacta_id_empleado_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.contacta_id_empleado_seq', 1, false);
          public          postgres    false    239            �           0    0    contiene_id_linea_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.contiene_id_linea_seq', 1, false);
          public          postgres    false    253            �           0    0    contiene_id_plan_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.contiene_id_plan_seq', 1, false);
          public          postgres    false    255            �           0    0    contiene_id_subplan_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.contiene_id_subplan_seq', 1, false);
          public          postgres    false    254            �           0    0 !   distribuidor_rif_distribuidor_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.distribuidor_rif_distribuidor_seq', 20, true);
          public          postgres    false    225            �           0    0    empleado_id_persona_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.empleado_id_persona_seq', 1, false);
          public          postgres    false    220            �           0    0    empresa_id_empresa_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.empresa_id_empresa_seq', 1, false);
          public          postgres    false    215            �           0    0 "   equipotelefonico_id_fabricante_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.equipotelefonico_id_fabricante_seq', 1, false);
          public          postgres    false    231            �           0    0     equipotelefonico_id_producto_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.equipotelefonico_id_producto_seq', 1, false);
          public          postgres    false    230            �           0    0    fabricante_id_fabricante_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.fabricante_id_fabricante_seq', 1, false);
          public          postgres    false    227            �           0    0    fabricante_rif_distribuidor_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.fabricante_rif_distribuidor_seq', 1, false);
          public          postgres    false    228            �           0    0    lineatelefonica_id_cliente_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.lineatelefonica_id_cliente_seq', 1, false);
          public          postgres    false    223            �           0    0    lineatelefonica_id_linea_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.lineatelefonica_id_linea_seq', 1, false);
          public          postgres    false    222            �           0    0    plan_id_producto_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.plan_id_producto_seq', 1, false);
          public          postgres    false    233            �           0    0    subplan_id_producto_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.subplan_id_producto_seq', 1, false);
          public          postgres    false    247            �           0    0    subplan_id_subplan_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.subplan_id_subplan_seq', 1, false);
          public          postgres    false    246            �           0    0 '   telefonoagenteautorizado_rif_agente_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.telefonoagenteautorizado_rif_agente_seq', 1, false);
          public          postgres    false    249            �           0    0    telefonoempresa_id_empresa_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.telefonoempresa_id_empresa_seq', 1, false);
          public          postgres    false    251            �           0    0    trabaja_id_persona_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.trabaja_id_persona_seq', 1, false);
          public          postgres    false    243            �           0    0    trabaja_rif_agente_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.trabaja_rif_agente_seq', 1, false);
          public          postgres    false    244            �           2606    59453 +   agenteautorizado agenteautorizado_email_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.agenteautorizado
    ADD CONSTRAINT agenteautorizado_email_key UNIQUE (email);
 U   ALTER TABLE ONLY public.agenteautorizado DROP CONSTRAINT agenteautorizado_email_key;
       public            postgres    false    242            �           2606    59451 &   agenteautorizado agenteautorizado_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.agenteautorizado
    ADD CONSTRAINT agenteautorizado_pkey PRIMARY KEY (rif_agente);
 P   ALTER TABLE ONLY public.agenteautorizado DROP CONSTRAINT agenteautorizado_pkey;
       public            postgres    false    242            �           2606    59285    cliente cliente_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_email_key UNIQUE (email);
 C   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_email_key;
       public            postgres    false    219            �           2606    59283    cliente cliente_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_persona);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    219            �           2606    59393    compra compra_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_pkey PRIMARY KEY (id_compra);
 <   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_pkey;
       public            postgres    false    237            �           2606    59527 &   contiene contiene_id_linea_id_plan_key 
   CONSTRAINT     n   ALTER TABLE ONLY public.contiene
    ADD CONSTRAINT contiene_id_linea_id_plan_key UNIQUE (id_linea, id_plan);
 P   ALTER TABLE ONLY public.contiene DROP CONSTRAINT contiene_id_linea_id_plan_key;
       public            postgres    false    256    256            �           2606    59333    distribuidor distribuidor_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.distribuidor
    ADD CONSTRAINT distribuidor_pkey PRIMARY KEY (rif_distribuidor);
 H   ALTER TABLE ONLY public.distribuidor DROP CONSTRAINT distribuidor_pkey;
       public            postgres    false    226            �           2606    59302    empleado empleado_email_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_email_key UNIQUE (email);
 E   ALTER TABLE ONLY public.empleado DROP CONSTRAINT empleado_email_key;
       public            postgres    false    221            �           2606    59300    empleado empleado_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (id_persona);
 @   ALTER TABLE ONLY public.empleado DROP CONSTRAINT empleado_pkey;
       public            postgres    false    221            �           2606    59259    empresa empresa_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (id_empresa);
 >   ALTER TABLE ONLY public.empresa DROP CONSTRAINT empresa_pkey;
       public            postgres    false    216            �           2606    59365 &   equipotelefonico equipotelefonico_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.equipotelefonico
    ADD CONSTRAINT equipotelefonico_pkey PRIMARY KEY (id_producto);
 P   ALTER TABLE ONLY public.equipotelefonico DROP CONSTRAINT equipotelefonico_pkey;
       public            postgres    false    232            �           2606    59346    fabricante fabricante_email_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.fabricante
    ADD CONSTRAINT fabricante_email_key UNIQUE (email);
 I   ALTER TABLE ONLY public.fabricante DROP CONSTRAINT fabricante_email_key;
       public            postgres    false    229            �           2606    59344    fabricante fabricante_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.fabricante
    ADD CONSTRAINT fabricante_pkey PRIMARY KEY (id_fabricante);
 D   ALTER TABLE ONLY public.fabricante DROP CONSTRAINT fabricante_pkey;
       public            postgres    false    229            �           2606    59319 $   lineatelefonica lineatelefonica_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.lineatelefonica
    ADD CONSTRAINT lineatelefonica_pkey PRIMARY KEY (id_linea);
 N   ALTER TABLE ONLY public.lineatelefonica DROP CONSTRAINT lineatelefonica_pkey;
       public            postgres    false    224            �           2606    59380    plan plan_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.plan
    ADD CONSTRAINT plan_pkey PRIMARY KEY (id_producto);
 8   ALTER TABLE ONLY public.plan DROP CONSTRAINT plan_pkey;
       public            postgres    false    234            �           2606    59483    subplan subplan_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.subplan
    ADD CONSTRAINT subplan_pkey PRIMARY KEY (id_subplan);
 >   ALTER TABLE ONLY public.subplan DROP CONSTRAINT subplan_pkey;
       public            postgres    false    248            �           2606    59497 6   telefonoagenteautorizado telefonoagenteautorizado_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.telefonoagenteautorizado
    ADD CONSTRAINT telefonoagenteautorizado_pkey PRIMARY KEY (telefono);
 `   ALTER TABLE ONLY public.telefonoagenteautorizado DROP CONSTRAINT telefonoagenteautorizado_pkey;
       public            postgres    false    250            �           2606    59511 $   telefonoempresa telefonoempresa_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.telefonoempresa
    ADD CONSTRAINT telefonoempresa_pkey PRIMARY KEY (telefono);
 N   ALTER TABLE ONLY public.telefonoempresa DROP CONSTRAINT telefonoempresa_pkey;
       public            postgres    false    252            �           2606    59467    trabaja trabaja_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.trabaja
    ADD CONSTRAINT trabaja_pkey PRIMARY KEY (id_persona);
 >   ALTER TABLE ONLY public.trabaja DROP CONSTRAINT trabaja_pkey;
       public            postgres    false    245            �           2620    59554     subplan actualizar_num_subplanes    TRIGGER     �   CREATE TRIGGER actualizar_num_subplanes AFTER INSERT ON public.subplan FOR EACH ROW EXECUTE FUNCTION public.actualizar_num_subplanes();
 9   DROP TRIGGER actualizar_num_subplanes ON public.subplan;
       public          postgres    false    261    248            �           2620    59547 $   contiene actualizar_numero_adscritos    TRIGGER     �   CREATE TRIGGER actualizar_numero_adscritos AFTER INSERT OR UPDATE ON public.contiene FOR EACH ROW EXECUTE FUNCTION public.actualizar_numero_adscritos();
 =   DROP TRIGGER actualizar_numero_adscritos ON public.contiene;
       public          postgres    false    257    256            �           2620    59551 #   trabaja actualizar_numero_empleados    TRIGGER     �   CREATE TRIGGER actualizar_numero_empleados AFTER INSERT OR UPDATE ON public.trabaja FOR EACH ROW EXECUTE FUNCTION public.actualizar_numero_empleados();
 <   DROP TRIGGER actualizar_numero_empleados ON public.trabaja;
       public          postgres    false    259    245            �           2620    59549 !   contacta actualizar_numero_ventas    TRIGGER     �   CREATE TRIGGER actualizar_numero_ventas AFTER INSERT OR UPDATE ON public.contacta FOR EACH ROW EXECUTE FUNCTION public.actualizar_numero_ventas();
 :   DROP TRIGGER actualizar_numero_ventas ON public.contacta;
       public          postgres    false    240    258            �           2620    59553    compra actualizar_precio_total    TRIGGER     �   CREATE TRIGGER actualizar_precio_total AFTER INSERT ON public.compra FOR EACH ROW EXECUTE FUNCTION public.actualizar_total_compra();
 7   DROP TRIGGER actualizar_precio_total ON public.compra;
       public          postgres    false    260    237            �           2606    59498 "   telefonoagenteautorizado fk_agente    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefonoagenteautorizado
    ADD CONSTRAINT fk_agente FOREIGN KEY (rif_agente) REFERENCES public.agenteautorizado(rif_agente) ON UPDATE CASCADE ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.telefonoagenteautorizado DROP CONSTRAINT fk_agente;
       public          postgres    false    242    4829    250            �           2606    59320    lineatelefonica fk_cliente    FK CONSTRAINT     �   ALTER TABLE ONLY public.lineatelefonica
    ADD CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_persona) ON UPDATE CASCADE ON DELETE SET NULL;
 D   ALTER TABLE ONLY public.lineatelefonica DROP CONSTRAINT fk_cliente;
       public          postgres    false    219    4807    224            �           2606    59394    compra fk_cliente    FK CONSTRAINT     �   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_persona) ON UPDATE CASCADE ON DELETE SET NULL;
 ;   ALTER TABLE ONLY public.compra DROP CONSTRAINT fk_cliente;
       public          postgres    false    219    4807    237            �           2606    59425    contacta fk_cliente    FK CONSTRAINT     �   ALTER TABLE ONLY public.contacta
    ADD CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_persona) ON UPDATE CASCADE ON DELETE SET NULL;
 =   ALTER TABLE ONLY public.contacta DROP CONSTRAINT fk_cliente;
       public          postgres    false    4807    219    240            �           2606    59286    cliente fk_cliente_empresa    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_cliente_empresa FOREIGN KEY (id_empresa) REFERENCES public.empresa(id_empresa) ON UPDATE CASCADE ON DELETE SET NULL;
 D   ALTER TABLE ONLY public.cliente DROP CONSTRAINT fk_cliente_empresa;
       public          postgres    false    216    4803    219            �           2606    59435    contacta fk_compra    FK CONSTRAINT     �   ALTER TABLE ONLY public.contacta
    ADD CONSTRAINT fk_compra FOREIGN KEY (id_compra) REFERENCES public.compra(id_compra) ON UPDATE CASCADE ON DELETE SET NULL;
 <   ALTER TABLE ONLY public.contacta DROP CONSTRAINT fk_compra;
       public          postgres    false    4825    237    240            �           2606    59347    fabricante fk_distribuidor    FK CONSTRAINT     �   ALTER TABLE ONLY public.fabricante
    ADD CONSTRAINT fk_distribuidor FOREIGN KEY (rif_distribuidor) REFERENCES public.distribuidor(rif_distribuidor) ON UPDATE CASCADE ON DELETE SET NULL;
 D   ALTER TABLE ONLY public.fabricante DROP CONSTRAINT fk_distribuidor;
       public          postgres    false    229    4815    226            �           2606    59430    contacta fk_empleado    FK CONSTRAINT     �   ALTER TABLE ONLY public.contacta
    ADD CONSTRAINT fk_empleado FOREIGN KEY (id_empleado) REFERENCES public.empleado(id_persona) ON UPDATE CASCADE ON DELETE SET NULL;
 >   ALTER TABLE ONLY public.contacta DROP CONSTRAINT fk_empleado;
       public          postgres    false    221    240    4811            �           2606    59512    telefonoempresa fk_empresa    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefonoempresa
    ADD CONSTRAINT fk_empresa FOREIGN KEY (id_empresa) REFERENCES public.empresa(id_empresa) ON UPDATE CASCADE ON DELETE SET NULL;
 D   ALTER TABLE ONLY public.telefonoempresa DROP CONSTRAINT fk_empresa;
       public          postgres    false    4803    252    216            �           2606    59366    equipotelefonico fk_fabricante    FK CONSTRAINT     �   ALTER TABLE ONLY public.equipotelefonico
    ADD CONSTRAINT fk_fabricante FOREIGN KEY (id_fabricante) REFERENCES public.fabricante(id_fabricante) ON UPDATE CASCADE ON DELETE SET NULL;
 H   ALTER TABLE ONLY public.equipotelefonico DROP CONSTRAINT fk_fabricante;
       public          postgres    false    232    229    4819            �           2606    59528    contiene fk_linea    FK CONSTRAINT     �   ALTER TABLE ONLY public.contiene
    ADD CONSTRAINT fk_linea FOREIGN KEY (id_linea) REFERENCES public.lineatelefonica(id_linea) ON UPDATE CASCADE ON DELETE SET NULL;
 ;   ALTER TABLE ONLY public.contiene DROP CONSTRAINT fk_linea;
       public          postgres    false    256    224    4813            �           2606    59468    trabaja fk_persona    FK CONSTRAINT     �   ALTER TABLE ONLY public.trabaja
    ADD CONSTRAINT fk_persona FOREIGN KEY (id_persona) REFERENCES public.empleado(id_persona) ON UPDATE CASCADE ON DELETE SET NULL;
 <   ALTER TABLE ONLY public.trabaja DROP CONSTRAINT fk_persona;
       public          postgres    false    4811    245    221            �           2606    59399    compra fk_plan    FK CONSTRAINT     �   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT fk_plan FOREIGN KEY (id_plan) REFERENCES public.plan(id_producto) ON UPDATE CASCADE ON DELETE SET NULL;
 8   ALTER TABLE ONLY public.compra DROP CONSTRAINT fk_plan;
       public          postgres    false    237    4823    234            �           2606    59484    subplan fk_plan    FK CONSTRAINT     �   ALTER TABLE ONLY public.subplan
    ADD CONSTRAINT fk_plan FOREIGN KEY (id_producto) REFERENCES public.plan(id_producto) ON UPDATE CASCADE ON DELETE SET NULL;
 9   ALTER TABLE ONLY public.subplan DROP CONSTRAINT fk_plan;
       public          postgres    false    4823    234    248            �           2606    59538    contiene fk_plan    FK CONSTRAINT     �   ALTER TABLE ONLY public.contiene
    ADD CONSTRAINT fk_plan FOREIGN KEY (id_plan) REFERENCES public.plan(id_producto) ON UPDATE CASCADE ON DELETE SET NULL;
 :   ALTER TABLE ONLY public.contiene DROP CONSTRAINT fk_plan;
       public          postgres    false    256    234    4823            �           2606    59404 $   compra fk_producto_equipo_telefonico    FK CONSTRAINT     �   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT fk_producto_equipo_telefonico FOREIGN KEY (id_equipo) REFERENCES public.equipotelefonico(id_producto) ON UPDATE CASCADE ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.compra DROP CONSTRAINT fk_producto_equipo_telefonico;
       public          postgres    false    4821    237    232            �           2606    59533    contiene fk_subplan    FK CONSTRAINT     �   ALTER TABLE ONLY public.contiene
    ADD CONSTRAINT fk_subplan FOREIGN KEY (id_subplan) REFERENCES public.subplan(id_subplan) ON UPDATE CASCADE ON DELETE SET NULL;
 =   ALTER TABLE ONLY public.contiene DROP CONSTRAINT fk_subplan;
       public          postgres    false    248    256    4833            �   i  x�}��N�@�ח��:�B��G�!�Wn��c:s�tj"��S�b��.�U����N�j��J��7G��n��6��=X����ѡ��`�8��~����~O�0�t�s�q��h��U�X�o��	V��m�k܎��Ut�]��T��|��`cH�:ZpMm?O#1����6���Rz_l|�߄��'�g�A���<Ē�Q���-Etd�?k�\�4޷`y事��T%yۜJZ5nk����a���)�9��c�%�s�#bOH7tY�U��?L�Ĩ*�����q�4��\a�}:��]
���X�P�;\����nNI�h���`�Fl��{<H����h�E������z?���L      �   �  x��V�n�J]WE~ D5�k��*��HV^���iϴ�D@;=`)��,��*�l��T�^��4���̩S�4B	�pY���_F=�o�L��x#���#]���Ń*ҽ���}�tV*��*�c�2	ߨ�{����C.����<�R���R�T�'�'I��9 ��)�4���w���5��)cqǋ��W��b���K�)���7�F����UN�J�@�S����Ӻ���Z˃�/[LB�'L����Rt����>�=A;Tc����|=��H�e_�S���UF �t�������-?��s�kW�;��+�	�E-��B�U���P�\ű���A������F*��I��4U��4���<D, р!�3}���S1:^H����^��4We�U0p5{zE8W��5����2-f
���4��!`!���deK�?��݈��w���];��E�e��{�M��E��(��ѧ�t)RB�N���l"����b�����6���٘�j���-�����XJxKS8b�s�cwD�ǰ��>�S}�y��" f	i���(�?���ibU1Ɋ�F�S{2�����d��*s��ӹa��Դ.�F�%��ϒWտ󱚄�E�R��D��R���-O�g�Z�^D�����ک<�W� ��'�%����#������- m�����l}�,�s�Z�&�R���D v^?��뛛A���A��a�G�t r�>�[��e�+�T�E��S�����v9+�kX�ȹ�ڮ�����'}k�q��v0������y�?��t��+�ȹl�H?(���C����Y�Ǔ��6�o�����I���a8�Bk��4l{�����T~��:߷:F�V�R�����������۲�k����1����_�?c��{?n5�a4_Z �T3L�6��UK[M<� nȁv�nh�(I]	#B�!��!�6dﳀo��)�#�춬��p���2��_���      �   �   x�M��1C��KF�&��鿎5K�F�;6B����]G�u#�'����'\�&J�@Y"�y�nj8y`
���6]4��;��E?P &�������O�i$�ˬ�&+[?2�]��Q�*���ql'^��UU�;b�(��kQ<��}��7K^T�\�'��kɨp֤7A�t���f��]=��$�#@����3#�Me      �     x�}�Mn� ���Sp�T;�Yg�]�u7԰���lU�Q=E.���iD#!=iě�8�َ�(��(E}(�/qr6,&Jܛ�l6�갫*I����gmըmԻ	ǋ����g��������f�iQ��g`vѫ��P�4���
�F��b���1��e�>F���wjH�֏����5��+�r�I�M+Ϳ����)���Ɍ}��f��%f0��ޏ�Cthr�������
�Pz�}��Km�]/_�E�͝�EU��3}�����(�oh��W      �   <   x�-���0�C1������בu�0c*V&;�45���zw�	��[��i�$�tI/T�	K      �   H  x���;n�0D��)|�@��e,�I�"HCD @6c}���YRK�0g�iv���J�<�a
�����x��&ص������!����j(.���xg�VR�/�0�ӡ�إ.�������B	����^(�V�$�{-?��ȼ���Ic��h�(� s�L\a�F��/x����DN�	�QL�4^h�U�i�i؆��S�s��y�۞�t�V5(f@9axs�fkm����c����ˢ��G�Q	$d���6�6K��C��Zҫ0Ds��錢9�`�29-�&È�_��Y&�7�í�R�M�֣�3)���/O���1�)nِ      �   �  x��U�n�0<S_����Dޒ&E�"�ȡ�ec3�=\:
�M�=�[���.eɢ���Ʉi���Ύ9#WM�%��kiwd]���f����9%��`[���	g���V��;W��[]<XW�[�]c VMV5=]��ɢ.	�B�4�&✜U@��{h_�)�{��Иf1S�
[-r�9~������m}[w?Y��PARb��8}�u]w�Fg�����rm���U���W1U1��5d���O����.�7v2��Փ��L*3\�:��i_�|��}q�<f,�Gy����pq�`���>R�!qP�n��#S�C��Q�����ծ}.&���(� �'�1/�� �e8��¦�b�����-#�F����}��PS��8�A�t6�����l�+��(7B�LE<#��1G�����h��Tz?N!e����]�dc݄�`Re��4�[ ��"x��E�q��E�K �2���f�g"��۠���E��#s� 7a����c#��;h�qG��ȤV��g�i �d]��_�ӗ>�4���x��p����!�#�&0\c3���>aá��[�ȃbLC<�?|$�,Q�E��3��8
�b�gi,�L�θ�h?�0��OX`�w>��4<0��_�{P�Y�ǹ�Է��q�t�=J/�q8��M�<C�w�!r#�̸�($TA��^� ���bC�0�'�
!r� �UH�fя$��?�l�      �     x�m��n�0�ϫ����s�e�)`�l$E��JZ[h2�H���wI%���$���4;K����D��.��;���(1~��0�Jl�Ϥ��H"�}�C�/0�F8RQ��[F
,�����V���@����&I��'�6�-g ����_N�~��dƌ��u�vd[��Q�*��3�Q��l`L�I4�o�H��󭥌`��j�0��>{%eS�'�D(m���R��������!U������ SX��EY��	�.rg��a��-��豨to�@c�`-�_�A�5��]P!\a�߆P~1��0�qa!�F��u�`Ͽ��9�b����ͅ�,o � M�h�+v�#��7C�(�E%>�j��o`9D��^�T�H�QޝP��
�|�:?������3`U��>�l�m�0%�a���<P��B�^�a��>�K��d||����[*�4�e;T��Ì +�_�(6��4�ŇCv�ɼ0���%##��m>���7~����CE� �V       �   r  x�e�kR�0�K��
2�vB��WSZ iB)�t��8�Ȓ���%t��l�ױ.$�o���9�^�N�4�)9/﬑�\ڕԖq���D"�����2'G�,Z�ĊF��{�Bukr6�F�1����q�Vb�%�	�{���PL�F���7���̚ͿBe�& H�ǯ�*�p
���v2�tHb�,�T	gA�f����tD�@���`�kOlQ������}�œ�{�&Wv-ke��tL�X�lz2ݫ�?���/TQB�)H��՜��<ȭz��1�Q�lE�a�7�����nyu���
�F�=<>V�w�9h�g�����>h��_�%�p����7�]|i2�5�c2�V�3�2(�p��E�y����^�
��]�M��h�m�$�o'F�Էo]��k���F��_���	3̂�%��������q�;|�=��;@��#a�X��><%��( ,���=�=�FV��n�Fjۿ#��鯃�<
�=Èwz�±��RV��c|�=���*S��c	1�6װ	�,5KRn�.{L��2`$� �f���߂O��B���]�s)t!���x�'x��h�铝�?�YC���8xy�!��?���ȉ�`      �   �  x����n�0E���D���T]��VYD���H������6H3#����4���w!�����qߪ8��&�"Q�����q
��us캪�nT~�$;��v�ЁΣ�b�kqX�)u˄�<+�*�'u"��^�q��¢<�m�~�S�J)3���my��f����D��p��'�!��G��hʡJ�G-�a@�P�c�q��t�[��qh���� E�8晎c�yq5��Zt�'�pm�z�����˸A�`y�zA� $ �ŹJ.�).sx�C��h��뺞�#��I��p���	�y��[lS�f;�"�}�jv��=��GkFͬ��F�B����ʫ�Kf���]����G����P���`ʛ��[�  X�|$h��4����(tpoWE��g`����\��H�7��� �      �   �   x�e�=O�1�gߏA��\F�P���R�*������B+ަ��Y~|qb�~�������Q���P�6���m���JF���㒪݊Z8�s�ߟ���0rj�{J���\b���lRQ�3"�Q��4�����]�8����r�5IG��R륥L&�f��ӊ���i���]�$�P���2K��^��^�dIh�i�	�UG�� 4��RY���^�-�v����R?��6dƲM]]�X)�w"�9|��      �   �   x�U����0���}�L�F��{�Uģ��VQj[�q�,���$�v�?��?y�:�d]�����v��ǉ� ¡�X8a����>�=����>
hK��(�,f�UN�ܨ��o��f�*�F�:�Ғ�0��N�䭗�;�x�}��AY6�揾{Sv��q��#�llb�)	Uv���C{�`�>rf1�Pg�[��>����<N�����L����R���a      �   	  x���KN�0���S�>�J���"�%je�f[(��ĕ�8��#�b�N�"A�����5����B@}z���4���i�aCֵ�*=Q[,Ӵ�a2�يK	u��Ǉ�,�t�,���H��>��
�@�@V�:R��ݫK.�htmC᥃�:Դ��:_Y��������y��wd��?������y��N�o��K��~�w�_kg"$Ρ��С����Z\��E���N�t��6���\�䓬C���y�v���'����z      �   P   x����@�76�%�ב�s5Z��������Zb�d�z��W�.����ʁ��������N�����?8�7      �   �   x�M��� C��0=��K�����M����Qdb7��0	t��H������B��J�s��d=gv7ݧ��{IۛsM����u[��i�����.��-"KU�K��C�����I3'1������_�v�lU�HY�>��]{B�<~5�1^E$~?c�c�N�      �     x���In�0E�U���j�1�%���D���)�"�!�W֫�z��� Dt!�{�4L�]���5{`B����\Ӝ�5UC�_�R`��k!`��`x����3���s?�v<�(��;��<�e���_��5�}�ǈ=`���wGz���SoU�e�w�<4(���O�|��Px}�F��m������A��妛�C�2C�ܚ��Q�Y���Ǩḅ�Wr��5�
�Y�s9ًSg䣄rn�ST�峊�rm��uA�_u^��     