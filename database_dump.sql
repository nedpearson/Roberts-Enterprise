--
-- PostgreSQL database dump
--

\restrict ZkWaiNN2SRuAP8PTBVAkYFGA0xqfRv4wDbi8GJySQCvNN72K0uK6Iam7ehM1ObE

-- Dumped from database version 15.17
-- Dumped by pg_dump version 15.17

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alterations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alterations (
    id integer NOT NULL,
    company_id integer,
    location_id integer,
    customer_id integer NOT NULL,
    item_description text NOT NULL,
    status text DEFAULT 'Awaiting 1st Fitting'::text,
    due_date timestamp without time zone,
    assigned_seamstress_id integer,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.alterations OWNER TO postgres;

--
-- Name: alterations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alterations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alterations_id_seq OWNER TO postgres;

--
-- Name: alterations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alterations_id_seq OWNED BY public.alterations.id;


--
-- Name: appointment_checklists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointment_checklists (
    id integer NOT NULL,
    appointment_id integer NOT NULL,
    type text NOT NULL,
    items_json text NOT NULL,
    completed_by integer,
    completed_at timestamp without time zone
);


ALTER TABLE public.appointment_checklists OWNER TO postgres;

--
-- Name: appointment_checklists_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointment_checklists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appointment_checklists_id_seq OWNER TO postgres;

--
-- Name: appointment_checklists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointment_checklists_id_seq OWNED BY public.appointment_checklists.id;


--
-- Name: appointment_participants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointment_participants (
    id integer NOT NULL,
    appointment_id integer NOT NULL,
    name text NOT NULL,
    relation text,
    phone text,
    notes text
);


ALTER TABLE public.appointment_participants OWNER TO postgres;

--
-- Name: appointment_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointment_participants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appointment_participants_id_seq OWNER TO postgres;

--
-- Name: appointment_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointment_participants_id_seq OWNED BY public.appointment_participants.id;


--
-- Name: appointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointments (
    id integer NOT NULL,
    location_id integer,
    customer_id integer NOT NULL,
    service_id integer NOT NULL,
    assigned_staff_id integer,
    start_at timestamp without time zone NOT NULL,
    end_at timestamp without time zone NOT NULL,
    status text DEFAULT 'Scheduled'::text,
    notes text,
    created_by integer,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.appointments OWNER TO postgres;

--
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appointments_id_seq OWNER TO postgres;

--
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;


--
-- Name: commission_tiers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commission_tiers (
    id integer NOT NULL,
    user_id integer NOT NULL,
    company_id integer NOT NULL,
    tier_level integer NOT NULL,
    revenue_threshold numeric NOT NULL,
    commission_rate numeric NOT NULL
);


ALTER TABLE public.commission_tiers OWNER TO postgres;

--
-- Name: commission_tiers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commission_tiers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commission_tiers_id_seq OWNER TO postgres;

--
-- Name: commission_tiers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commission_tiers_id_seq OWNED BY public.commission_tiers.id;


--
-- Name: commissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    order_id integer,
    description text,
    amount real NOT NULL,
    status text DEFAULT 'Pending'::text,
    earned_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.commissions OWNER TO postgres;

--
-- Name: commissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commissions_id_seq OWNER TO postgres;

--
-- Name: commissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commissions_id_seq OWNED BY public.commissions.id;


--
-- Name: communication_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.communication_logs (
    id integer NOT NULL,
    company_id integer NOT NULL,
    customer_id integer NOT NULL,
    type text NOT NULL,
    subject text,
    message_body text NOT NULL,
    status text DEFAULT 'Sent'::text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.communication_logs OWNER TO postgres;

--
-- Name: communication_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.communication_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.communication_logs_id_seq OWNER TO postgres;

--
-- Name: communication_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.communication_logs_id_seq OWNED BY public.communication_logs.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies (
    id integer NOT NULL,
    name text NOT NULL,
    domain text,
    logo_url text,
    primary_color text DEFAULT '#aa8c66'::text,
    theme_bg text DEFAULT 'dark'::text,
    active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    stripe_secret_key text,
    stripe_publishable_key text,
    qb_client_id text,
    qb_client_secret text,
    qb_access_token text,
    qb_refresh_token text,
    qb_realm_id text
);


ALTER TABLE public.companies OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_id_seq OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: customer_measurements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_measurements (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    bust real DEFAULT 0.0,
    waist real DEFAULT 0.0,
    hips real DEFAULT 0.0,
    hollow_to_hem real DEFAULT 0.0,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.customer_measurements OWNER TO postgres;

--
-- Name: customer_measurements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_measurements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_measurements_id_seq OWNER TO postgres;

--
-- Name: customer_measurements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_measurements_id_seq OWNED BY public.customer_measurements.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    company_id integer,
    location_id integer,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text,
    phone text,
    address text,
    notes text,
    wedding_date timestamp without time zone,
    partner_name text,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: designer_size_charts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.designer_size_charts (
    id integer NOT NULL,
    vendor_id integer NOT NULL,
    size_label text NOT NULL,
    bust real NOT NULL,
    waist real NOT NULL,
    hips real NOT NULL
);


ALTER TABLE public.designer_size_charts OWNER TO postgres;

--
-- Name: designer_size_charts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.designer_size_charts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.designer_size_charts_id_seq OWNER TO postgres;

--
-- Name: designer_size_charts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.designer_size_charts_id_seq OWNED BY public.designer_size_charts.id;


--
-- Name: employee_regulations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_regulations (
    id integer NOT NULL,
    user_id integer NOT NULL,
    company_id integer NOT NULL,
    allow_discounts boolean DEFAULT false,
    max_discount_percent numeric(5,2) DEFAULT 0.00,
    allow_refunds boolean DEFAULT false,
    require_manager_approval_above numeric(10,2) DEFAULT 0.00,
    can_edit_shifts boolean DEFAULT false,
    can_view_wholesale_pricing boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.employee_regulations OWNER TO postgres;

--
-- Name: employee_regulations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_regulations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_regulations_id_seq OWNER TO postgres;

--
-- Name: employee_regulations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_regulations_id_seq OWNED BY public.employee_regulations.id;


--
-- Name: global_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.global_settings (
    id integer NOT NULL,
    company_id integer NOT NULL,
    require_pin_for_clock_in boolean DEFAULT false,
    require_pin_for_login boolean DEFAULT false
);


ALTER TABLE public.global_settings OWNER TO postgres;

--
-- Name: global_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.global_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.global_settings_id_seq OWNER TO postgres;

--
-- Name: global_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.global_settings_id_seq OWNED BY public.global_settings.id;


--
-- Name: location_inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.location_inventory (
    id integer NOT NULL,
    location_id integer NOT NULL,
    product_variant_id integer NOT NULL,
    qty_on_hand integer DEFAULT 0
);


ALTER TABLE public.location_inventory OWNER TO postgres;

--
-- Name: location_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.location_inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.location_inventory_id_seq OWNER TO postgres;

--
-- Name: location_inventory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.location_inventory_id_seq OWNED BY public.location_inventory.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    company_id integer NOT NULL,
    name text NOT NULL,
    address text,
    phone text,
    email text,
    active boolean DEFAULT true
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_id_seq OWNER TO postgres;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: notification_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification_jobs (
    id integer NOT NULL,
    reminder_id integer,
    channel text NOT NULL,
    recipient text NOT NULL,
    payload text NOT NULL,
    status text DEFAULT 'Queued'::text,
    error_log text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.notification_jobs OWNER TO postgres;

--
-- Name: notification_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_jobs_id_seq OWNER TO postgres;

--
-- Name: notification_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_jobs_id_seq OWNED BY public.notification_jobs.id;


--
-- Name: notification_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification_preferences (
    id integer NOT NULL,
    customer_id integer,
    user_id integer,
    email_opt_in boolean DEFAULT true,
    sms_opt_in boolean DEFAULT true,
    in_app_opt_in boolean DEFAULT true
);


ALTER TABLE public.notification_preferences OWNER TO postgres;

--
-- Name: notification_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_preferences_id_seq OWNER TO postgres;

--
-- Name: notification_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_preferences_id_seq OWNED BY public.notification_preferences.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_variant_id integer,
    service_id integer,
    description text NOT NULL,
    qty integer DEFAULT 1 NOT NULL,
    unit_price real NOT NULL,
    line_total real NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    company_id integer,
    location_id integer,
    customer_id integer NOT NULL,
    status text DEFAULT 'Draft'::text,
    subtotal real DEFAULT 0.0,
    tax real DEFAULT 0.0,
    total real DEFAULT 0.0,
    wedding_date_snapshot timestamp without time zone,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    sold_by_id integer
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: payment_ledger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_ledger (
    id integer NOT NULL,
    order_id integer NOT NULL,
    customer_id integer NOT NULL,
    type text NOT NULL,
    amount real NOT NULL,
    method text NOT NULL,
    occurred_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    reference text,
    memo text,
    created_by integer,
    immutable_hash text
);


ALTER TABLE public.payment_ledger OWNER TO postgres;

--
-- Name: payment_ledger_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_ledger_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_ledger_id_seq OWNER TO postgres;

--
-- Name: payment_ledger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_ledger_id_seq OWNED BY public.payment_ledger.id;


--
-- Name: payment_plans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_plans (
    id integer NOT NULL,
    order_id integer NOT NULL,
    terms text,
    installment_count integer DEFAULT 1,
    next_due_date timestamp without time zone
);


ALTER TABLE public.payment_plans OWNER TO postgres;

--
-- Name: payment_plans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_plans_id_seq OWNER TO postgres;

--
-- Name: payment_plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_plans_id_seq OWNED BY public.payment_plans.id;


--
-- Name: paystubs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paystubs (
    id integer NOT NULL,
    company_id integer,
    user_id integer NOT NULL,
    period_start date,
    period_end date,
    total_hours real DEFAULT 0.0,
    hourly_rate real DEFAULT 0.0,
    base_pay real DEFAULT 0.0,
    commission_pay real DEFAULT 0.0,
    bonus_pay real DEFAULT 0.0,
    total_pay real DEFAULT 0.0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by integer
);


ALTER TABLE public.paystubs OWNER TO postgres;

--
-- Name: paystubs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paystubs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.paystubs_id_seq OWNER TO postgres;

--
-- Name: paystubs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paystubs_id_seq OWNED BY public.paystubs.id;


--
-- Name: pickup_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pickup_items (
    id integer NOT NULL,
    pickup_id integer NOT NULL,
    order_item_id integer NOT NULL,
    checklist_status boolean DEFAULT false
);


ALTER TABLE public.pickup_items OWNER TO postgres;

--
-- Name: pickup_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pickup_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pickup_items_id_seq OWNER TO postgres;

--
-- Name: pickup_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pickup_items_id_seq OWNED BY public.pickup_items.id;


--
-- Name: pickups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pickups (
    id integer NOT NULL,
    company_id integer,
    location_id integer,
    order_id integer NOT NULL,
    customer_id integer NOT NULL,
    scheduled_at timestamp without time zone,
    status text DEFAULT 'Scheduled'::text,
    pickup_contact_name text,
    pickup_contact_phone text,
    notes text,
    signed_at timestamp without time zone,
    signed_by text
);


ALTER TABLE public.pickups OWNER TO postgres;

--
-- Name: pickups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pickups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pickups_id_seq OWNER TO postgres;

--
-- Name: pickups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pickups_id_seq OWNED BY public.pickups.id;


--
-- Name: product_variants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_variants (
    id integer NOT NULL,
    product_id integer NOT NULL,
    size text,
    color text,
    sku_variant text NOT NULL,
    on_hand_qty integer DEFAULT 0,
    track_inventory boolean DEFAULT true
);


ALTER TABLE public.product_variants OWNER TO postgres;

--
-- Name: product_variants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_variants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_variants_id_seq OWNER TO postgres;

--
-- Name: product_variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_variants_id_seq OWNED BY public.product_variants.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    vendor_id integer,
    type text NOT NULL,
    brand text,
    name text NOT NULL,
    sku text NOT NULL,
    cost real DEFAULT 0.0 NOT NULL,
    price real DEFAULT 0.0 NOT NULL,
    active boolean DEFAULT true
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: purchase_order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_order_items (
    id integer NOT NULL,
    purchase_order_id integer NOT NULL,
    product_variant_id integer NOT NULL,
    qty_ordered integer NOT NULL,
    qty_received integer DEFAULT 0,
    unit_cost real NOT NULL
);


ALTER TABLE public.purchase_order_items OWNER TO postgres;

--
-- Name: purchase_order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_order_items_id_seq OWNER TO postgres;

--
-- Name: purchase_order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_order_items_id_seq OWNED BY public.purchase_order_items.id;


--
-- Name: purchase_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_orders (
    id integer NOT NULL,
    vendor_id integer NOT NULL,
    order_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    expected_delivery timestamp without time zone,
    status text DEFAULT 'Draft'::text,
    total_cost real DEFAULT 0.0,
    notes text,
    created_by integer
);


ALTER TABLE public.purchase_orders OWNER TO postgres;

--
-- Name: purchase_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_orders_id_seq OWNER TO postgres;

--
-- Name: purchase_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_orders_id_seq OWNED BY public.purchase_orders.id;


--
-- Name: reminders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reminders (
    id integer NOT NULL,
    type text NOT NULL,
    reference_id integer NOT NULL,
    trigger_at timestamp without time zone NOT NULL,
    status text DEFAULT 'Pending'::text
);


ALTER TABLE public.reminders OWNER TO postgres;

--
-- Name: reminders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reminders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reminders_id_seq OWNER TO postgres;

--
-- Name: reminders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reminders_id_seq OWNED BY public.reminders.id;


--
-- Name: reservations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservations (
    id integer NOT NULL,
    product_variant_id integer NOT NULL,
    customer_id integer NOT NULL,
    appointment_id integer,
    reserve_from timestamp without time zone NOT NULL,
    reserve_to timestamp without time zone NOT NULL,
    status text DEFAULT 'Held'::text,
    notes text
);


ALTER TABLE public.reservations OWNER TO postgres;

--
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservations_id_seq OWNER TO postgres;

--
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservations_id_seq OWNED BY public.reservations.id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id integer NOT NULL,
    company_id integer,
    name text NOT NULL,
    duration_minutes integer NOT NULL,
    default_price real DEFAULT 0.0,
    buffer_minutes integer DEFAULT 0,
    active boolean DEFAULT true
);


ALTER TABLE public.services OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_id_seq OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: shifts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shifts (
    id integer NOT NULL,
    company_id integer NOT NULL,
    location_id integer NOT NULL,
    user_id integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    notes text
);


ALTER TABLE public.shifts OWNER TO postgres;

--
-- Name: shifts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shifts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shifts_id_seq OWNER TO postgres;

--
-- Name: shifts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shifts_id_seq OWNED BY public.shifts.id;


--
-- Name: time_entries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.time_entries (
    id integer NOT NULL,
    user_id integer NOT NULL,
    location_id integer,
    clock_in timestamp without time zone NOT NULL,
    clock_out timestamp without time zone,
    total_hours real,
    approved boolean DEFAULT false,
    status text DEFAULT 'Unpaid'::text,
    notes text
);


ALTER TABLE public.time_entries OWNER TO postgres;

--
-- Name: time_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.time_entries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.time_entries_id_seq OWNER TO postgres;

--
-- Name: time_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.time_entries_id_seq OWNED BY public.time_entries.id;


--
-- Name: transfer_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transfer_items (
    id integer NOT NULL,
    transfer_id integer NOT NULL,
    product_variant_id integer NOT NULL,
    qty integer NOT NULL
);


ALTER TABLE public.transfer_items OWNER TO postgres;

--
-- Name: transfer_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transfer_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transfer_items_id_seq OWNER TO postgres;

--
-- Name: transfer_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transfer_items_id_seq OWNED BY public.transfer_items.id;


--
-- Name: transfers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transfers (
    id integer NOT NULL,
    company_id integer NOT NULL,
    from_location_id integer NOT NULL,
    to_location_id integer NOT NULL,
    status text DEFAULT 'In_Transit'::text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by integer,
    received_at timestamp without time zone,
    received_by integer,
    notes text
);


ALTER TABLE public.transfers OWNER TO postgres;

--
-- Name: transfers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transfers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transfers_id_seq OWNER TO postgres;

--
-- Name: transfers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transfers_id_seq OWNED BY public.transfers.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    company_id integer,
    location_id integer,
    email text NOT NULL,
    password_hash text NOT NULL,
    role text DEFAULT 'Viewer'::text NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    commission_type text DEFAULT 'NONE'::text,
    commission_rate real DEFAULT 0.0,
    commission_locations text,
    hourly_wage real DEFAULT 0.0,
    bonus real DEFAULT 0.0,
    pin_hash character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: vendors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendors (
    id integer NOT NULL,
    company_id integer,
    name text NOT NULL,
    contact_name text,
    email text,
    phone text,
    portal_url text,
    notes text,
    active boolean DEFAULT true,
    lead_time_weeks integer DEFAULT 16
);


ALTER TABLE public.vendors OWNER TO postgres;

--
-- Name: vendors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vendors_id_seq OWNER TO postgres;

--
-- Name: vendors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendors_id_seq OWNED BY public.vendors.id;


--
-- Name: alterations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alterations ALTER COLUMN id SET DEFAULT nextval('public.alterations_id_seq'::regclass);


--
-- Name: appointment_checklists id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment_checklists ALTER COLUMN id SET DEFAULT nextval('public.appointment_checklists_id_seq'::regclass);


--
-- Name: appointment_participants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment_participants ALTER COLUMN id SET DEFAULT nextval('public.appointment_participants_id_seq'::regclass);


--
-- Name: appointments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);


--
-- Name: commission_tiers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commission_tiers ALTER COLUMN id SET DEFAULT nextval('public.commission_tiers_id_seq'::regclass);


--
-- Name: commissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commissions ALTER COLUMN id SET DEFAULT nextval('public.commissions_id_seq'::regclass);


--
-- Name: communication_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communication_logs ALTER COLUMN id SET DEFAULT nextval('public.communication_logs_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: customer_measurements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_measurements ALTER COLUMN id SET DEFAULT nextval('public.customer_measurements_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: designer_size_charts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.designer_size_charts ALTER COLUMN id SET DEFAULT nextval('public.designer_size_charts_id_seq'::regclass);


--
-- Name: employee_regulations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_regulations ALTER COLUMN id SET DEFAULT nextval('public.employee_regulations_id_seq'::regclass);


--
-- Name: global_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_settings ALTER COLUMN id SET DEFAULT nextval('public.global_settings_id_seq'::regclass);


--
-- Name: location_inventory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_inventory ALTER COLUMN id SET DEFAULT nextval('public.location_inventory_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: notification_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_jobs ALTER COLUMN id SET DEFAULT nextval('public.notification_jobs_id_seq'::regclass);


--
-- Name: notification_preferences id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_preferences ALTER COLUMN id SET DEFAULT nextval('public.notification_preferences_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: payment_ledger id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_ledger ALTER COLUMN id SET DEFAULT nextval('public.payment_ledger_id_seq'::regclass);


--
-- Name: payment_plans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_plans ALTER COLUMN id SET DEFAULT nextval('public.payment_plans_id_seq'::regclass);


--
-- Name: paystubs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paystubs ALTER COLUMN id SET DEFAULT nextval('public.paystubs_id_seq'::regclass);


--
-- Name: pickup_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_items ALTER COLUMN id SET DEFAULT nextval('public.pickup_items_id_seq'::regclass);


--
-- Name: pickups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickups ALTER COLUMN id SET DEFAULT nextval('public.pickups_id_seq'::regclass);


--
-- Name: product_variants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variants ALTER COLUMN id SET DEFAULT nextval('public.product_variants_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: purchase_order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_items ALTER COLUMN id SET DEFAULT nextval('public.purchase_order_items_id_seq'::regclass);


--
-- Name: purchase_orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders ALTER COLUMN id SET DEFAULT nextval('public.purchase_orders_id_seq'::regclass);


--
-- Name: reminders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reminders ALTER COLUMN id SET DEFAULT nextval('public.reminders_id_seq'::regclass);


--
-- Name: reservations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations ALTER COLUMN id SET DEFAULT nextval('public.reservations_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: shifts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shifts ALTER COLUMN id SET DEFAULT nextval('public.shifts_id_seq'::regclass);


--
-- Name: time_entries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.time_entries ALTER COLUMN id SET DEFAULT nextval('public.time_entries_id_seq'::regclass);


--
-- Name: transfer_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfer_items ALTER COLUMN id SET DEFAULT nextval('public.transfer_items_id_seq'::regclass);


--
-- Name: transfers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers ALTER COLUMN id SET DEFAULT nextval('public.transfers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: vendors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors ALTER COLUMN id SET DEFAULT nextval('public.vendors_id_seq'::regclass);


--
-- Data for Name: alterations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alterations (id, company_id, location_id, customer_id, item_description, status, due_date, assigned_seamstress_id, notes, created_at) FROM stdin;
\.


--
-- Data for Name: appointment_checklists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointment_checklists (id, appointment_id, type, items_json, completed_by, completed_at) FROM stdin;
\.


--
-- Data for Name: appointment_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointment_participants (id, appointment_id, name, relation, phone, notes) FROM stdin;
\.


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointments (id, location_id, customer_id, service_id, assigned_staff_id, start_at, end_at, status, notes, created_by, updated_at) FROM stdin;
\.


--
-- Data for Name: commission_tiers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commission_tiers (id, user_id, company_id, tier_level, revenue_threshold, commission_rate) FROM stdin;
\.


--
-- Data for Name: commissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commissions (id, user_id, order_id, description, amount, status, earned_at) FROM stdin;
\.


--
-- Data for Name: communication_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.communication_logs (id, company_id, customer_id, type, subject, message_body, status, created_at) FROM stdin;
1	1	1	SMS	Arrival Alert: Stella York 7336	Exciting news, Test! Your Stella York 7336 has officially arrived. Please call us to schedule your fitting/pickup.	Sent	2026-03-07 20:58:23.674168
2	1	1	Email	Arrival Alert: Stella York 7336	Hello Test,\n\nWe are thrilled to inform you that your Stella York 7336 has officially arrived at the boutique!\n\nPlease give us a call at your earliest convenience to get your next fitting or pickup scheduled on the calendar.\n\nWarmly,\nThe Boutique Team	Sent	2026-03-07 20:58:23.684752
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies (id, name, domain, logo_url, primary_color, theme_bg, active, created_at, stripe_secret_key, stripe_publishable_key, qb_client_id, qb_client_secret, qb_access_token, qb_refresh_token, qb_realm_id) FROM stdin;
2	Proper & Co	properandcompany.com	//properandcompany.com/cdn/shop/files/Proper_and_Co_white_logo_2048x2048.png	#000000	custom_proper	t	2026-03-06 01:37:30	\N	\N	\N	\N	\N	\N	\N
3	Roberts Enterprise	robertsenterprise.com	\N	#aa8c66	dark	t	2026-03-07 20:45:50.72636	\N	\N	\N	\N	\N	\N	\N
1	I Do Bridal Couture	idobridalcouture.com	//idobridalcouture.com/cdn/shop/files/IDO-Logo-Br-and-Cov-WHT-01a_2048x2048.png	#666666	custom_idc	t	2026-03-06 01:37:30	sk_test_67890	pk_test_12345			\N	\N	\N
\.


--
-- Data for Name: customer_measurements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_measurements (id, customer_id, bust, waist, hips, hollow_to_hem, updated_at) FROM stdin;
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, company_id, location_id, first_name, last_name, email, phone, address, notes, wedding_date, partner_name, created_by, created_at) FROM stdin;
1	1	\N	Test	Bride	test_bride@example.com	+15551234567	\N	\N	\N	\N	\N	2026-03-07 20:58:23.618879
\.


--
-- Data for Name: designer_size_charts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.designer_size_charts (id, vendor_id, size_label, bust, waist, hips) FROM stdin;
\.


--
-- Data for Name: employee_regulations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee_regulations (id, user_id, company_id, allow_discounts, max_discount_percent, allow_refunds, require_manager_approval_above, can_edit_shifts, can_view_wholesale_pricing, updated_at) FROM stdin;
\.


--
-- Data for Name: global_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.global_settings (id, company_id, require_pin_for_clock_in, require_pin_for_login) FROM stdin;
\.


--
-- Data for Name: location_inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.location_inventory (id, location_id, product_variant_id, qty_on_hand) FROM stdin;
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locations (id, company_id, name, address, phone, email, active) FROM stdin;
1	1	Baton Rouge	Baton Rouge, LA	\N	\N	t
2	1	Covington	Covington, LA	\N	\N	t
6	3	All Locations	\N	\N	\N	t
3	2	Dallas HQ	Louisiana	\N	\N	t
4	2	Houston	Baton Rouge, LA	\N	\N	t
5	2	Austin	Covington, LA	\N	\N	t
\.


--
-- Data for Name: notification_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_jobs (id, reminder_id, channel, recipient, payload, status, error_log, created_at) FROM stdin;
\.


--
-- Data for Name: notification_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_preferences (id, customer_id, user_id, email_opt_in, sms_opt_in, in_app_opt_in) FROM stdin;
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_variant_id, service_id, description, qty, unit_price, line_total) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, company_id, location_id, customer_id, status, subtotal, tax, total, wedding_date_snapshot, notes, created_at, sold_by_id) FROM stdin;
\.


--
-- Data for Name: payment_ledger; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_ledger (id, order_id, customer_id, type, amount, method, occurred_at, reference, memo, created_by, immutable_hash) FROM stdin;
\.


--
-- Data for Name: payment_plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_plans (id, order_id, terms, installment_count, next_due_date) FROM stdin;
\.


--
-- Data for Name: paystubs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paystubs (id, company_id, user_id, period_start, period_end, total_hours, hourly_rate, base_pay, commission_pay, bonus_pay, total_pay, created_at, created_by) FROM stdin;
\.


--
-- Data for Name: pickup_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pickup_items (id, pickup_id, order_item_id, checklist_status) FROM stdin;
\.


--
-- Data for Name: pickups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pickups (id, company_id, location_id, order_id, customer_id, scheduled_at, status, pickup_contact_name, pickup_contact_phone, notes, signed_at, signed_by) FROM stdin;
\.


--
-- Data for Name: product_variants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_variants (id, product_id, size, color, sku_variant, on_hand_qty, track_inventory) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, vendor_id, type, brand, name, sku, cost, price, active) FROM stdin;
\.


--
-- Data for Name: purchase_order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_order_items (id, purchase_order_id, product_variant_id, qty_ordered, qty_received, unit_cost) FROM stdin;
\.


--
-- Data for Name: purchase_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_orders (id, vendor_id, order_date, expected_delivery, status, total_cost, notes, created_by) FROM stdin;
\.


--
-- Data for Name: reminders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reminders (id, type, reference_id, trigger_at, status) FROM stdin;
\.


--
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservations (id, product_variant_id, customer_id, appointment_id, reserve_from, reserve_to, status, notes) FROM stdin;
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, company_id, name, duration_minutes, default_price, buffer_minutes, active) FROM stdin;
\.


--
-- Data for Name: shifts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shifts (id, company_id, location_id, user_id, start_time, end_time, notes) FROM stdin;
\.


--
-- Data for Name: time_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.time_entries (id, user_id, location_id, clock_in, clock_out, total_hours, approved, status, notes) FROM stdin;
2	12	6	2026-03-07 22:24:14.033395	2026-03-07 22:24:15.079481	0.00029057945	f	Unpaid	\N
\.


--
-- Data for Name: transfer_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transfer_items (id, transfer_id, product_variant_id, qty) FROM stdin;
\.


--
-- Data for Name: transfers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transfers (id, company_id, from_location_id, to_location_id, status, created_at, created_by, received_at, received_by, notes) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, company_id, location_id, email, password_hash, role, first_name, last_name, active, created_at, commission_type, commission_rate, commission_locations, hourly_wage, bonus, pin_hash) FROM stdin;
4	1	1	admin@bridal.ai	foo	Stylist	Admin	User	t	2026-03-06 06:12:55	NONE	0	\N	25.5	500	\N
5	1	1	sarah@bridal.ai	hash	Stylist	Sarah	Smith	t	2026-03-06 06:12:55	LOCATION	5	2	0	0	\N
6	1	1	emily@bridal.ai	hash	Stylist	Emily	Chen	t	2026-03-06 06:12:55	NONE	0	\N	0	0	\N
7	1	1	jessica@bridal.ai	hash	Stylist	Jessica	Miller	t	2026-03-06 06:12:55	NONE	0	\N	0	0	\N
8	1	1	amanda@bridal.ai	hash	Stylist	Amanda	Rose	t	2026-03-06 06:12:55	NONE	0	\N	0	0	\N
9	1	1	john.doe@example.com	scrypt:32768:8:1$atMrGpynA2y77qll$21e784de93c1b6e9b7a6d176cc957ce11a71635e21a30d4dc55c4c946f88e69ebacf3c968f776cb49edd97c6cb3ecd1dc9b030978145186edfb3104bcbc12bf2	Stylist	John	Doe	t	2026-03-07 01:28:51	NONE	0	\N	0	0	\N
10	1	1	admin@idobridalcouture.com	scrypt:32768:8:1$U1SeXQluF7ZTEmOB$8d96cba9779418abc6dc919001673d65f99a24ca59640f14fda4aeeb5ff7198515d36a03d2dca30451c373eaa227c33105b2758babd6994f97367f8c19ea585c	Owner	System	Admin	t	2026-03-07 20:34:31.663407	NONE	0	\N	0	0	scrypt:32768:8:1$0ZVU9df3yoS1Xz8g$49c978627949e8d84f11c3b79071651cd2acc0b5852b91bd9f1b7fca561bcae852bfbdacd71770632ab196b573742c01aef2b4efe97622c45435aadb617bdd13
11	2	3	admin@properandco.com	scrypt:32768:8:1$UPg8A7x3KXPyVxrc$d5ae8a251e160d87d1d31fb8356521e4d8ed4c8556947e1c907a769a46fe7443cd07ce4154130b9c042454aac2aac70822c195019c835b978d487a241a32dceb	Owner	System	Admin	t	2026-03-07 20:34:31.663407	NONE	0	\N	0	0	scrypt:32768:8:1$0ZVU9df3yoS1Xz8g$49c978627949e8d84f11c3b79071651cd2acc0b5852b91bd9f1b7fca561bcae852bfbdacd71770632ab196b573742c01aef2b4efe97622c45435aadb617bdd13
12	3	6	admin@robertsenterprise.com	scrypt:32768:8:1$U2NMYQ38Z1d8Sjy8$35852b2302d91f3e2b0b59e4ae7f1e9f17ede7b48b0cd93b9214a7ce49c7c59674b9339ead6338261c1ef461ed8e4f53f4ac0278996967af2048771e927ae81a	Owner	System	Admin	t	2026-03-07 20:45:50.72636	NONE	0	\N	0	0	scrypt:32768:8:1$0ZVU9df3yoS1Xz8g$49c978627949e8d84f11c3b79071651cd2acc0b5852b91bd9f1b7fca561bcae852bfbdacd71770632ab196b573742c01aef2b4efe97622c45435aadb617bdd13
\.


--
-- Data for Name: vendors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendors (id, company_id, name, contact_name, email, phone, portal_url, notes, active, lead_time_weeks) FROM stdin;
\.


--
-- Name: alterations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alterations_id_seq', 1, false);


--
-- Name: appointment_checklists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointment_checklists_id_seq', 1, false);


--
-- Name: appointment_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointment_participants_id_seq', 1, false);


--
-- Name: appointments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointments_id_seq', 1, false);


--
-- Name: commission_tiers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commission_tiers_id_seq', 1, false);


--
-- Name: commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commissions_id_seq', 1, false);


--
-- Name: communication_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.communication_logs_id_seq', 2, true);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_id_seq', 3, true);


--
-- Name: customer_measurements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_measurements_id_seq', 1, false);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 2, true);


--
-- Name: designer_size_charts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.designer_size_charts_id_seq', 1, false);


--
-- Name: employee_regulations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_regulations_id_seq', 1, false);


--
-- Name: global_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.global_settings_id_seq', 1, false);


--
-- Name: location_inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.location_inventory_id_seq', 1, false);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locations_id_seq', 6, true);


--
-- Name: notification_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_jobs_id_seq', 1, false);


--
-- Name: notification_preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_preferences_id_seq', 1, false);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 1, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, true);


--
-- Name: payment_ledger_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_ledger_id_seq', 1, false);


--
-- Name: payment_plans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_plans_id_seq', 1, false);


--
-- Name: paystubs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paystubs_id_seq', 1, false);


--
-- Name: pickup_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pickup_items_id_seq', 1, false);


--
-- Name: pickups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pickups_id_seq', 1, false);


--
-- Name: product_variants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_variants_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 1, false);


--
-- Name: purchase_order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_order_items_id_seq', 1, false);


--
-- Name: purchase_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_orders_id_seq', 1, false);


--
-- Name: reminders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reminders_id_seq', 1, false);


--
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservations_id_seq', 1, false);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 1, false);


--
-- Name: shifts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shifts_id_seq', 1, false);


--
-- Name: time_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.time_entries_id_seq', 2, true);


--
-- Name: transfer_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transfer_items_id_seq', 1, false);


--
-- Name: transfers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transfers_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 12, true);


--
-- Name: vendors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendors_id_seq', 1, false);


--
-- Name: alterations alterations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alterations
    ADD CONSTRAINT alterations_pkey PRIMARY KEY (id);


--
-- Name: appointment_checklists appointment_checklists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment_checklists
    ADD CONSTRAINT appointment_checklists_pkey PRIMARY KEY (id);


--
-- Name: appointment_participants appointment_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment_participants
    ADD CONSTRAINT appointment_participants_pkey PRIMARY KEY (id);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- Name: commission_tiers commission_tiers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commission_tiers
    ADD CONSTRAINT commission_tiers_pkey PRIMARY KEY (id);


--
-- Name: commissions commissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT commissions_pkey PRIMARY KEY (id);


--
-- Name: communication_logs communication_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communication_logs
    ADD CONSTRAINT communication_logs_pkey PRIMARY KEY (id);


--
-- Name: companies companies_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_name_key UNIQUE (name);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: customer_measurements customer_measurements_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_measurements
    ADD CONSTRAINT customer_measurements_customer_id_key UNIQUE (customer_id);


--
-- Name: customer_measurements customer_measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_measurements
    ADD CONSTRAINT customer_measurements_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: designer_size_charts designer_size_charts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.designer_size_charts
    ADD CONSTRAINT designer_size_charts_pkey PRIMARY KEY (id);


--
-- Name: employee_regulations employee_regulations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_regulations
    ADD CONSTRAINT employee_regulations_pkey PRIMARY KEY (id);


--
-- Name: global_settings global_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_settings
    ADD CONSTRAINT global_settings_pkey PRIMARY KEY (id);


--
-- Name: location_inventory location_inventory_location_id_product_variant_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_inventory
    ADD CONSTRAINT location_inventory_location_id_product_variant_id_key UNIQUE (location_id, product_variant_id);


--
-- Name: location_inventory location_inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_inventory
    ADD CONSTRAINT location_inventory_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: notification_jobs notification_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_jobs
    ADD CONSTRAINT notification_jobs_pkey PRIMARY KEY (id);


--
-- Name: notification_preferences notification_preferences_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_preferences
    ADD CONSTRAINT notification_preferences_customer_id_key UNIQUE (customer_id);


--
-- Name: notification_preferences notification_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_preferences
    ADD CONSTRAINT notification_preferences_pkey PRIMARY KEY (id);


--
-- Name: notification_preferences notification_preferences_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_preferences
    ADD CONSTRAINT notification_preferences_user_id_key UNIQUE (user_id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: payment_ledger payment_ledger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_ledger
    ADD CONSTRAINT payment_ledger_pkey PRIMARY KEY (id);


--
-- Name: payment_plans payment_plans_order_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_plans
    ADD CONSTRAINT payment_plans_order_id_key UNIQUE (order_id);


--
-- Name: payment_plans payment_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_plans
    ADD CONSTRAINT payment_plans_pkey PRIMARY KEY (id);


--
-- Name: paystubs paystubs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paystubs
    ADD CONSTRAINT paystubs_pkey PRIMARY KEY (id);


--
-- Name: pickup_items pickup_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_items
    ADD CONSTRAINT pickup_items_pkey PRIMARY KEY (id);


--
-- Name: pickups pickups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickups
    ADD CONSTRAINT pickups_pkey PRIMARY KEY (id);


--
-- Name: product_variants product_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_pkey PRIMARY KEY (id);


--
-- Name: product_variants product_variants_sku_variant_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_sku_variant_key UNIQUE (sku_variant);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products products_sku_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_sku_key UNIQUE (sku);


--
-- Name: purchase_order_items purchase_order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_items
    ADD CONSTRAINT purchase_order_items_pkey PRIMARY KEY (id);


--
-- Name: purchase_orders purchase_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_pkey PRIMARY KEY (id);


--
-- Name: reminders reminders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reminders
    ADD CONSTRAINT reminders_pkey PRIMARY KEY (id);


--
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: shifts shifts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shifts
    ADD CONSTRAINT shifts_pkey PRIMARY KEY (id);


--
-- Name: time_entries time_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.time_entries
    ADD CONSTRAINT time_entries_pkey PRIMARY KEY (id);


--
-- Name: transfer_items transfer_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfer_items
    ADD CONSTRAINT transfer_items_pkey PRIMARY KEY (id);


--
-- Name: transfers transfers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vendors vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (id);


--
-- Name: alterations alterations_assigned_seamstress_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alterations
    ADD CONSTRAINT alterations_assigned_seamstress_id_fkey FOREIGN KEY (assigned_seamstress_id) REFERENCES public.users(id);


--
-- Name: alterations alterations_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alterations
    ADD CONSTRAINT alterations_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: alterations alterations_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alterations
    ADD CONSTRAINT alterations_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- Name: alterations alterations_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alterations
    ADD CONSTRAINT alterations_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: appointment_checklists appointment_checklists_appointment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment_checklists
    ADD CONSTRAINT appointment_checklists_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointments(id) ON DELETE CASCADE;


--
-- Name: appointment_checklists appointment_checklists_completed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment_checklists
    ADD CONSTRAINT appointment_checklists_completed_by_fkey FOREIGN KEY (completed_by) REFERENCES public.users(id);


--
-- Name: appointment_participants appointment_participants_appointment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment_participants
    ADD CONSTRAINT appointment_participants_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointments(id) ON DELETE CASCADE;


--
-- Name: appointments appointments_assigned_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_assigned_staff_id_fkey FOREIGN KEY (assigned_staff_id) REFERENCES public.users(id);


--
-- Name: appointments appointments_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: appointments appointments_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: appointments appointments_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: appointments appointments_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: commission_tiers commission_tiers_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commission_tiers
    ADD CONSTRAINT commission_tiers_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: commission_tiers commission_tiers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commission_tiers
    ADD CONSTRAINT commission_tiers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: commissions commissions_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT commissions_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: commissions commissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT commissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: communication_logs communication_logs_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communication_logs
    ADD CONSTRAINT communication_logs_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: communication_logs communication_logs_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communication_logs
    ADD CONSTRAINT communication_logs_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- Name: customer_measurements customer_measurements_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_measurements
    ADD CONSTRAINT customer_measurements_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- Name: customers customers_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: customers customers_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: customers customers_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: designer_size_charts designer_size_charts_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.designer_size_charts
    ADD CONSTRAINT designer_size_charts_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(id) ON DELETE CASCADE;


--
-- Name: employee_regulations employee_regulations_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_regulations
    ADD CONSTRAINT employee_regulations_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: employee_regulations employee_regulations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_regulations
    ADD CONSTRAINT employee_regulations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: global_settings global_settings_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_settings
    ADD CONSTRAINT global_settings_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: location_inventory location_inventory_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_inventory
    ADD CONSTRAINT location_inventory_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: location_inventory location_inventory_product_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_inventory
    ADD CONSTRAINT location_inventory_product_variant_id_fkey FOREIGN KEY (product_variant_id) REFERENCES public.product_variants(id);


--
-- Name: locations locations_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: notification_jobs notification_jobs_reminder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_jobs
    ADD CONSTRAINT notification_jobs_reminder_id_fkey FOREIGN KEY (reminder_id) REFERENCES public.reminders(id) ON DELETE SET NULL;


--
-- Name: notification_preferences notification_preferences_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_preferences
    ADD CONSTRAINT notification_preferences_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: notification_preferences notification_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_preferences
    ADD CONSTRAINT notification_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_product_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_variant_id_fkey FOREIGN KEY (product_variant_id) REFERENCES public.product_variants(id);


--
-- Name: order_items order_items_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: orders orders_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: orders orders_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: orders orders_sold_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_sold_by_id_fkey FOREIGN KEY (sold_by_id) REFERENCES public.users(id);


--
-- Name: payment_ledger payment_ledger_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_ledger
    ADD CONSTRAINT payment_ledger_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: payment_ledger payment_ledger_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_ledger
    ADD CONSTRAINT payment_ledger_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: payment_ledger payment_ledger_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_ledger
    ADD CONSTRAINT payment_ledger_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: payment_plans payment_plans_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_plans
    ADD CONSTRAINT payment_plans_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: paystubs paystubs_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paystubs
    ADD CONSTRAINT paystubs_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: paystubs paystubs_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paystubs
    ADD CONSTRAINT paystubs_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: paystubs paystubs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paystubs
    ADD CONSTRAINT paystubs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: pickup_items pickup_items_order_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_items
    ADD CONSTRAINT pickup_items_order_item_id_fkey FOREIGN KEY (order_item_id) REFERENCES public.order_items(id);


--
-- Name: pickup_items pickup_items_pickup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_items
    ADD CONSTRAINT pickup_items_pickup_id_fkey FOREIGN KEY (pickup_id) REFERENCES public.pickups(id) ON DELETE CASCADE;


--
-- Name: pickups pickups_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickups
    ADD CONSTRAINT pickups_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: pickups pickups_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickups
    ADD CONSTRAINT pickups_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: pickups pickups_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickups
    ADD CONSTRAINT pickups_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: pickups pickups_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickups
    ADD CONSTRAINT pickups_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: product_variants product_variants_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products products_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- Name: purchase_order_items purchase_order_items_product_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_items
    ADD CONSTRAINT purchase_order_items_product_variant_id_fkey FOREIGN KEY (product_variant_id) REFERENCES public.product_variants(id);


--
-- Name: purchase_order_items purchase_order_items_purchase_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_items
    ADD CONSTRAINT purchase_order_items_purchase_order_id_fkey FOREIGN KEY (purchase_order_id) REFERENCES public.purchase_orders(id) ON DELETE CASCADE;


--
-- Name: purchase_orders purchase_orders_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: purchase_orders purchase_orders_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- Name: reservations reservations_appointment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointments(id);


--
-- Name: reservations reservations_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: reservations reservations_product_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_product_variant_id_fkey FOREIGN KEY (product_variant_id) REFERENCES public.product_variants(id);


--
-- Name: services services_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: shifts shifts_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shifts
    ADD CONSTRAINT shifts_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: shifts shifts_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shifts
    ADD CONSTRAINT shifts_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: shifts shifts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shifts
    ADD CONSTRAINT shifts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: time_entries time_entries_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.time_entries
    ADD CONSTRAINT time_entries_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: time_entries time_entries_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.time_entries
    ADD CONSTRAINT time_entries_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: transfer_items transfer_items_product_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfer_items
    ADD CONSTRAINT transfer_items_product_variant_id_fkey FOREIGN KEY (product_variant_id) REFERENCES public.product_variants(id);


--
-- Name: transfer_items transfer_items_transfer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfer_items
    ADD CONSTRAINT transfer_items_transfer_id_fkey FOREIGN KEY (transfer_id) REFERENCES public.transfers(id) ON DELETE CASCADE;


--
-- Name: transfers transfers_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: transfers transfers_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: transfers transfers_from_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_from_location_id_fkey FOREIGN KEY (from_location_id) REFERENCES public.locations(id);


--
-- Name: transfers transfers_received_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_received_by_fkey FOREIGN KEY (received_by) REFERENCES public.users(id);


--
-- Name: transfers transfers_to_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_to_location_id_fkey FOREIGN KEY (to_location_id) REFERENCES public.locations(id);


--
-- Name: users users_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: users users_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: vendors vendors_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- PostgreSQL database dump complete
--

\unrestrict ZkWaiNN2SRuAP8PTBVAkYFGA0xqfRv4wDbi8GJySQCvNN72K0uK6Iam7ehM1ObE

