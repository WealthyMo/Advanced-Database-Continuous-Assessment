-- ============================================================================
-- MIT 8103: Constraint Validation Tests (15 Test Cases)
-- Student: Mosunmola Theresa Olanrewaju (ID: 301930059)
-- Purpose: Verify database integrity by executing invalid SQL statements.
-- Expected Result: Each statement MUST fail at the specified constraint.
-- ============================================================================

-- 1. venue pk
INSERT INTO portfolio.venue (venue_id, name, city, capacity) VALUES (1, 'Distinct Venue', 'Bend', 40);

-- 2. venue unique
INSERT INTO portfolio.venue (venue_id, name, city, capacity) VALUES (101, 'Harbor Hall', 'Portland', 40);

-- 3. venue not null
INSERT INTO portfolio.venue (venue_id, name, city, capacity) VALUES (102, NULL, 'Bend', 40);

-- 4. venue check (positive capacity)
INSERT INTO portfolio.venue (venue_id, name, city, capacity) VALUES (103, 'Zero Capacity Venue', 'Bend', 0);

-- 5. event pk
INSERT INTO portfolio.event (event_id, venue_id, title, starts_at, ends_at, status) VALUES (11, 1, 'Duplicate Event ID', '2027-06-01T10:00:00Z', '2027-06-01T12:00:00Z', 'published');

-- 6. event fk
INSERT INTO portfolio.event (event_id, venue_id, title, starts_at, ends_at, status) VALUES (111, 9001, 'Missing Venue Event', '2027-06-01T10:00:00Z', '2027-06-01T12:00:00Z', 'published');

-- 7. event check (time order)
INSERT INTO portfolio.event (event_id, venue_id, title, starts_at, ends_at, status) VALUES (112, 1, 'Reversed Time Event', '2027-06-01T12:00:00Z', '2027-06-01T10:00:00Z', 'published');

-- 8. ticket type pk
INSERT INTO portfolio.ticket_type (ticket_type_id, event_id, label, price, capacity, sold_count) VALUES (21, 12, 'Different Category', 12, 20, 0);

-- 9. ticket type unique
INSERT INTO portfolio.ticket_type (ticket_type_id, event_id, label, price, capacity, sold_count) VALUES (121, 11, 'General', 12, 20, 0);

-- 10. ticket type fk
INSERT INTO portfolio.ticket_type (ticket_type_id, event_id, label, price, capacity, sold_count) VALUES (122, 9002, 'Missing Event Category', 12, 20, 0);

-- 11. ticket type check (inventory bounds)
INSERT INTO portfolio.ticket_type (ticket_type_id, event_id, label, price, capacity, sold_count) VALUES (123, 11, 'Overbooked Category', 12, 20, 21);

-- 12. booking pk
INSERT INTO portfolio.booking (booking_id, ticket_type_id, attendee_email, booked_at, status, confirmation_code) VALUES (31, 21, 'pk-test@example.test', '2027-03-04T10:00:00Z', 'confirmed', 'SYNTH-PK-TEST');

-- 13. booking unique
INSERT INTO portfolio.booking (booking_id, ticket_type_id, attendee_email, booked_at, status, confirmation_code) VALUES (131, 21, 'unique-test@example.test', '2027-03-04T10:00:00Z', 'confirmed', 'SYNTH-A31');

-- 14. booking fk
INSERT INTO portfolio.booking (booking_id, ticket_type_id, attendee_email, booked_at, status, confirmation_code) VALUES (132, 9003, 'fk-test@example.test', '2027-03-04T10:00:00Z', 'confirmed', 'SYNTH-FK-TEST');

-- 15. booking check (valid status)
INSERT INTO portfolio.booking (booking_id, ticket_type_id, attendee_email, booked_at, status, confirmation_code) VALUES (133, 21, 'check-test@example.test', '2027-03-04T10:00:00Z', 'pending', 'SYNTH-CHECK-TEST');
