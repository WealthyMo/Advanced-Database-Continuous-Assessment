# Portfolio 5: Distributed and Cloud Database Architecture

**Student:** Mosunmola Theresa Olanrewaju (Student ID: 301930059)  
**Case Study:** Event Ticketing & Venue Booking Platform (PassGate Africa)  

---

## 1. Cloud Replica Set Deployment Proposal
To guarantee high availability and prevent single points of failure during major ticket releases, a 3-node MongoDB Replica Set architecture is proposed across three distinct availability zones (AZs):

* **Node 1 (Primary):** Located in Zone A (Handles all write operations and strong-consistency reads).
* **Node 2 (Secondary):** Located in Zone B (Replicates primary operations asynchronously; serves read-heavy analytical workloads).
* **Node 3 (Secondary/Arbiter):** Located in Zone C (Maintains quorum for automated primary elections during outages).

---

## 2. Failover, Consistency, and Sharding Strategy
* **Automated Failover:** Uses Raft-based election consensus. If the Primary node goes offline, the remaining nodes elect a new Primary within seconds.
* **Write Concern (`majority`):** Guarantees that ticket reservations are acknowledged only after being written to a majority of nodes, eliminating data loss.
* **Horizontal Sharding:** The `ticketing_events` collection is sharded across regions using a compound key (`venue.city` + `event_id`) to distribute computational throughput evenly.
