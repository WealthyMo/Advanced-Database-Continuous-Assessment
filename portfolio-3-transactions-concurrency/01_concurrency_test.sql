-- ============================================================================
-- MIT 8103: Portfolio 3 - Transactions & Concurrency Control
-- Student: Mosunmola Theresa Olanrewaju (ID: 301930059)
-- Case Study: Event Ticketing & Venue Booking Platform
-- ============================================================================

-- 1. Demonstrate ROLLBACK (Safety Net)
BEGIN;
UPDATE portfolio.ticket_type 
SET sold_count = sold_count + 1 
WHERE ticket_type_id = 1;

-- Cancel changes and restore original state
ROLLBACK;


-- 2. Safe Concurrent Booking Simulation using Row-Level Locking
-- SESSION A (First Buyer): Locks row before updating
BEGIN;
SELECT * FROM portfolio.ticket_type 
WHERE ticket_type_id = 1 
FOR UPDATE;

UPDATE portfolio.ticket_type 
SET sold_count = sold_count + 1 
WHERE ticket_type_id = 1;

COMMIT;
