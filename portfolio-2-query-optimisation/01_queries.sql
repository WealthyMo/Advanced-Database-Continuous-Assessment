-- ============================================================================
-- MIT 8103: Portfolio 2 - Query Processing and Optimization
-- Student: Mosunmola Theresa Olanrewaju (ID: 301930059)
-- Case Study: Event Ticketing & Venue Booking Platform
-- ============================================================================

-- Query 1: Join venues and events to find scheduled shows
SELECT v.name AS venue_name, v.city, e.title AS event_title, e.starts_at
FROM portfolio.venue v
JOIN portfolio.event e ON v.venue_id = e.venue_id
WHERE v.name = 'Harbor Hall';

-- Query 2: EXPLAIN ANALYZE lookup BEFORE creating an index (Sequential Scan)
EXPLAIN ANALYZE
SELECT * FROM portfolio.booking 
WHERE attendee_email = 'user24500@example.test';

-- Query 3: Create index on attendee_email to speed up lookups
CREATE INDEX idx_booking_attendee_email ON portfolio.booking(attendee_email);

-- Query 4: EXPLAIN ANALYZE lookup AFTER creating index (Index Scan)
EXPLAIN ANALYZE
SELECT * FROM portfolio.booking 
WHERE attendee_email = 'user24500@example.test';
