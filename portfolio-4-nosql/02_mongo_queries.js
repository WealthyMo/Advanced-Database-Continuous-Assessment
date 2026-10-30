// ============================================================================
// MIT 8103: Portfolio 4 - NoSQL Integration (MongoDB Script)
// Student: Mosunmola Theresa Olanrewaju (ID: 301930059)
// Case Study: Event Ticketing & Venue Booking Platform
// ============================================================================

db.ticketing_events.insertMany([
  {
    event_id: 101,
    title: "Afrobeats Live Fest",
    starts_at: ISODate("2027-12-20T18:00:00Z"),
    status: "published",
    venue: { name: "Eko Convention Centre", city: "Lagos" },
    tags: ["music", "concert"],
    lineup: ["Burna Boy", "Wizkid"]
  },
  {
    event_id: 102,
    title: "Tech Innovators Summit",
    starts_at: ISODate("2027-11-15T09:00:00Z"),
    status: "published",
    venue: { name: "Landmark Centre", city: "Lagos" },
    tags: ["tech", "conference"],
    speakers: ["Mosunmola Olanrewaju", "Tech Leaders"]
  }
]);

db.ticketing_events.find({ "venue.city": "Lagos", status: "published" });
