# MIT 8103: Advanced Database Systems
## Final Practical Database Portfolio Submission

**Student Name:** Mosunmola Theresa Olanrewaju  
**Student ID:** 301930059  
**Degree Program:** Master of Information Technology (MIT)  
**Institution:** MIVA Open University  
**Academic Session:** 2026/2027 Academic Session — First Semester  
**Course Code & Title:** MIT 8103: Advanced Database Systems  
**GitHub Repository URL:** https://github.com/WealthyMo/Olanrewaju_Mosunmola_301930059

---

## 1. Selected Organisation & Case Study Overview

### Organisation & System Scenario: PassGate Africa
PassGate Africa is a web-based event ticketing and venue booking platform designed to facilitate ticket publishing, venue resource scheduling, real-time ticket reservations, and analytics reporting.

* **Primary Database Users:** Venue Coordinators, Event Organizers, Ticketing Staff, and Event Attendees.
* **Core Entities & Data Managed:** Physical Venues (`venue`), Scheduled Events (`event`), Categorized Ticket Inventory (`ticket_type`), and Customer Reservations (`booking`).
* **Key Supported Operations:**
  1. Registering venues and establishing capacity bounds.
  2. Publishing and querying events filtered by venue location and date ranges.
  3. Processing concurrent real-time ticket reservations and cancellations.
  4. Summarizing total booking sales metrics and attendance numbers.

---

## 2. Portfolio Summaries and Technical Evidence

### Portfolio 1: Database Design and Modelling
The relational core was normalized into four distinct tables in PostgreSQL (`venue`, `event`, `ticket_type`, and `booking`) to ensure Third Normal Form (3NF) compliance and eliminate redundancy.

* **Integrity Enforcement:** Primary keys (PK) enforce entity identity, foreign keys (FK) maintain referential integrity with cascading updates, and `CHECK` constraints enforce business domain validation (e.g., enforcing positive venue capacities `capacity > 0` and chronological timestamp order `ends_at > starts_at`).
* **Negative Constraint Testing:** Schema robustness was validated by executing 15 deliberately invalid SQL operations (covering primary key collisions, foreign key mismatches, null violations, and domain rule breaches). All 15 tests failed as expected with explicit `SQLSTATE` error codes without corrupting valid baseline data.

---

### Portfolio 2: Query Processing and Optimization
Operational performance was evaluated using relational join queries and high-volume indexing benchmarks.

* **Multi-Table Joins:** Querying scheduled venue events returned accurate schedule reports (e.g., retrieving Spring Arts Night hosted at Harbor Hall).
* **Performance Benchmarking:** An operational table populated with 25,000 synthetic booking records was evaluated using `EXPLAIN ANALYZE`:
  * **Before Indexing (Sequential Scan):** Median query lookup time was **1.324 ms** as PostgreSQL scanned all 25,000 rows.
  * **After Indexing (Index Scan):** Creating a B-tree index (`idx_booking_attendee_email`) reduced median query lookup time down to **0.193 ms**.
  * **Analysis:** The execution plan confirmed an **~85% reduction** in lookup latency and reduced I/O block reads.

---

### Portfolio 3: Transactions and Concurrency Control
Transaction safety and isolation mechanics were analyzed under PostgreSQL's default `READ COMMITTED` isolation level.

* **ACID Compliance:** Explicit `COMMIT` and `ROLLBACK` blocks verified that uncommitted modifications remain completely isolated from concurrent database sessions and that aborted transactions restore the prior committed state cleanly.
* **Concurrency Control:** Simulating simultaneous multi-session bookings revealed a classic **Lost Update Anomaly** during uncoordinated concurrent reads. Applying pessimistic row-level locking via `SELECT ... FOR UPDATE` serialized concurrent access, forcing Session B to wait for Session A's commit, guaranteeing exact inventory accounting.

---

### Portfolio 4: NoSQL and Advanced Data Models
Dynamic, unstructured workloads were modeled using MongoDB document collections (`ticketing_events`).

* **Document Structure & Embedded Snapshots:** To optimize read speeds, venue and organizer metadata are embedded directly inside event JSON documents, removing the need for costly multi-document lookup joins.
* **Validation & Query Execution:** Strict JSON Schema rules enforced data types (rejecting malformed date strings and duplicate identifiers). Four operational queries validated document lookup performance for published events across regions.

---

### Portfolio 5: Distributed and Cloud Database Architecture
A cloud-native MongoDB deployment model was designed to guarantee system availability during high-traffic ticket drops.

* **3-Node Replica Set Deployment:** Configured across three distinct cloud Availability Zones (Zone A: Primary, Zone B: Secondary, Zone C: Secondary/Arbiter).
* **Failover & Consistency:** Employs Raft consensus for automated failover within 3 seconds and utilizes a write concern of `majority` to prevent data loss.
* **Horizontal Scaling:** Implements database sharding partitioned on a compound shard key (`venue.city` + `event_id`) to distribute write throughput across nodes.

---

## 3. Individual Technical Reflection

Designing and implementing the database architecture for PassGate Africa reinforced the critical importance of selecting appropriate storage paradigms for distinct operational workloads. Decoupling core entities into normalized relational tables eliminated data redundancy and simplified domain maintenance. Enforcing domain invariants at the database layer through SQL constraints provided robust data protection, guaranteeing that malformed data is rejected regardless of application-level bugs.

The transaction concurrency experiments highlighted the risks of high-concurrency race conditions. Observing how uncoordinated reads lead to lost updates during simultaneous bookings demonstrated why pessimistic row locking (`SELECT ... FOR UPDATE`) is critical for inventory preservation. Furthermore, query performance analysis using `EXPLAIN ANALYZE` proved that verifying database performance requires inspecting query execution plans rather than relying solely on query output correctness.

---

## 4. Academic Integrity & AI-Use Declaration

I hereby declare that this practical portfolio represents my individual work. In preparing the database schemas, test scripts, and documentation, I utilized GitHub Copilot and the MIT 8103 Portfolio Generator as learning and productivity aids.

* **Tool Usage:** Generative tools assisted in creating boilerplate SQL DDL statements, MongoDB scripts, and structural documentation templates.
* **Verification & Review:** I executed all SQL and JavaScript scripts within local PostgreSQL and MongoDB environments, verified output tables and execution plan timings, resolved schema errors, and ensured that all explanations accurately reflect my individual understanding of the system architecture.

---

## 5. References

* MongoDB, Inc. (2024). *MongoDB Documentation: Data Modeling Introduction*. Retrieved from https://www.mongodb.com/docs/manual/data-modeling/
* MongoDB, Inc. (2024). *MongoDB Documentation: Replication*. Retrieved from https://www.mongodb.com/docs/manual/replication/
* MongoDB, Inc. (2024). *MongoDB Documentation: Sharding*. Retrieved from https://www.mongodb.com/docs/manual/sharding/
* PostgreSQL Global Development Group. (2024). *PostgreSQL Documentation: Data Definition - Constraints*. Retrieved from https://www.postgresql.org/docs/17/ddl-constraints.html
* PostgreSQL Global Development Group. (2024). *PostgreSQL Documentation: Explicit Locking*. Retrieved from https://www.postgresql.org/docs/17/explicit-locking.html
* PostgreSQL Global Development Group. (2024). *PostgreSQL Documentation: Transaction Isolation*. Retrieved from https://www.postgresql.org/docs/17/transaction-iso.html
* PostgreSQL Global Development Group. (2024). *PostgreSQL Documentation: Using EXPLAIN*. Retrieved from https://www.postgresql.org/docs/17/using-explain.html
