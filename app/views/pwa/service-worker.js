// Cache the offline fallback page on install:
self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open("offline").then((cache) => cache.add("/offline")),
  );
  self.skipWaiting();
});

// Serve the offline fallback page when a navigation request fails:
self.addEventListener("fetch", (event) => {
  if (event.request.mode === "navigate") {
    event.respondWith(
      fetch(event.request).catch(() => caches.match("/offline")),
    );
  }
});
