# Advanced-Database-Continuous-Assessment
MIT 8103 Advanced Database Systems Portfolio
-- ============================================================================
-- MIT 8103: Advanced Database Systems
-- Student: Mosunmola Theresa Olanrewaju (ID: 301930059)
-- Case Study: Event Ticketing & Venue Booking Platform
-- File: portfolio-1-database-design/01_schema.sql
-- ============================================================================

CREATE SCHEMA IF NOT EXISTS portfolio;

-- 1. VENUE TABLE
CREATE TABLE portfolio.venue (
    venue_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    city VARCHAR(100) NOT NULL,
    capacity INT NOT NULL CONSTRAINT venue_capacity_positive CHECK (capacity > 0),
    CONSTRAINT uq_venue_0 UNIQUE (name, city)
);

-- 2. EVENT TABLE
CREATE TABLE portfolio.event (
    event_id SERIAL PRIMARY KEY,
    venue_id INT NOT NULL REFERENCES portfolio.venue(venue_id) ON DELETE CASCADE,
    title VARCHAR(200) NOT NULL,
    starts_at TIMESTAMPTZ NOT NULL,
    ends_at TIMESTAMPTZ NOT NULL,
    status VARCHAR(20) DEFAULT 'published' CHECK (status IN ('draft', 'published', 'cancelled')),
    CONSTRAINT event_time_order CHECK (ends_at > starts_at)
);

-- 3. TICKET TYPE TABLE
CREATE TABLE portfolio.ticket_type (
    ticket_type_id SERIAL PRIMARY KEY,
    event_id INT NOT NULL REFERENCES portfolio.event(event_id) ON DELETE CASCADE,
    label VARCHAR(50) NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    capacity INT NOT NULL CHECK (capacity > 0),
    sold_count INT DEFAULT 0 CHECK (sold_count >= 0),
    CONSTRAINT ticket_inventory_bounds CHECK (sold_count <= capacity),
    CONSTRAINT uq_ticket_type_0 UNIQUE (event_id, label)
);

-- 4. BOOKING TABLE
CREATE TABLE portfolio.booking (
    booking_id SERIAL PRIMARY KEY,
    ticket_type_id INT NOT NULL REFERENCES portfolio.ticket_type(ticket_type_id) ON DELETE CASCADE,
    attendee_email VARCHAR(255) NOT NULL,
    booked_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'confirmed' CONSTRAINT booking_status_valid CHECK (status IN ('confirmed', 'cancelled')),
    confirmation_code VARCHAR(50) NOT NULL UNIQUE
);