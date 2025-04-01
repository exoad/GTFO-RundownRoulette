'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"android-chrome-192x192.png": "13308dac3f832a30a364ed6a1a819e50",
"android-chrome-512x512.png": "e4534be8b815c1f2c96ec2d58f0ecf44",
"apple-touch-icon.png": "6a6d583a428cd6d79943ee92bed4dc43",
"assets/AssetManifest.bin": "06bb4d7ebd6ad4cbcdaf50d2cd377807",
"assets/AssetManifest.bin.json": "1e45a636d4ce34fe6aca13e1b56bbbae",
"assets/AssetManifest.json": "c2498e1a787b8f3e06dc1d09482fa8c6",
"assets/assets/icon.png": "b6d037e8aa6542dbeb816604e0f8a489",
"assets/assets/ingame/aggressive.png": "613ea870edfa8a45719de7b1a0962e3d",
"assets/assets/ingame/assaultrifle.png": "8e307b7bbb9c67937da64d66c2a74292",
"assets/assets/ingame/autosentry.png": "7b17af8b537f0cc5b193c6d55529e6c2",
"assets/assets/ingame/bat.png": "bbbc749844765a0cb33751ba0f70bee4",
"assets/assets/ingame/biotracker.png": "25ee866d4ab9313760796cf8a7c39d15",
"assets/assets/ingame/bishop.png": "2cb10f70d98a87c1a567d5883f4bf2c3",
"assets/assets/ingame/bold.png": "b9e295dd04242d658d51d9e19d28d406",
"assets/assets/ingame/bullpuprifle.png": "aa8f3b289a14b0a98c89b5b4808843a4",
"assets/assets/ingame/burstcannon.png": "27cde48c1cce41f4f0db34dd09e313fb",
"assets/assets/ingame/burstpistol.png": "34b5294b101e166b9ebd042a63c70ca9",
"assets/assets/ingame/burstrifle.png": "539e4dfa73bfdf6338f915535c2532b2",
"assets/assets/ingame/burstsentry.png": "3f33ecec02d94eab2e76655ccbc3fbaf",
"assets/assets/ingame/carbine.png": "49a4c332395eb10341085ac0121ae22d",
"assets/assets/ingame/cfoam.png": "391d8b8e62be0b6bb544062850250700",
"assets/assets/ingame/chokemodshotgun.png": "d83eb86955d73336a5eb9590d58831a8",
"assets/assets/ingame/combatshotgun.png": "3da7dddad0047433823b2f9d748ab2c7",
"assets/assets/ingame/dauda.png": "6f69c5c23a7467c5d16907847613c4e9",
"assets/assets/ingame/dmr.png": "91a38ec8c5fc49f0891be1c4f8195ab4",
"assets/assets/ingame/doubletaprifle.png": "fb61bff8c5e6b5644369d8b478a52aba",
"assets/assets/ingame/hackett.png": "db3eb300c9079d2056137776c31c75fe",
"assets/assets/ingame/hammer.png": "4e9171444ec996bc9c52df0e804851bc",
"assets/assets/ingame/heavyassaultrifle.png": "dd22342779282259b0592bdacf284a7f",
"assets/assets/ingame/heavysmg.png": "7cd312610d57bfbcb2a28cda167f5e19",
"assets/assets/ingame/helautopistol.png": "1dd59046160933324363e334ed37d1dd",
"assets/assets/ingame/helgun.png": "3edae285952e02e4aec195a722123b09",
"assets/assets/ingame/helrevolver.png": "944ee0d92d4987d7bbc8ba0b9d1f558a",
"assets/assets/ingame/helrifle.png": "791a259570323a5195516cf05ad23de1",
"assets/assets/ingame/helshotgun.png": "eb71fef37dc30ee21657eb78db9c5cb5",
"assets/assets/ingame/highcalpistol.png": "31a9e0044cf6d18e087c811634415763",
"assets/assets/ingame/knife.png": "fd200b50cec82b62ee160a33fa4d80f5",
"assets/assets/ingame/machinegunarbalist.png": "52df417bf516759d6f1803f07b2f84d1",
"assets/assets/ingame/machinegunveruta.png": "0b628b4bc3343fd0969c9e75444efa08",
"assets/assets/ingame/machinepistol.png": "471cd9a83ea685bbd6346f4b5ff3d0df",
"assets/assets/ingame/minedeployer.png": "3ae9659b9a8b843467ba7157994cd8b1",
"assets/assets/ingame/muted.png": "98ea51f971f7f5f59df245fe837a33d6",
"assets/assets/ingame/pdw.png": "1f8d6432945969b1323dea397e5b1f23",
"assets/assets/ingame/pistol.png": "756e28faa0704b485b2e60fe3b017498",
"assets/assets/ingame/precisionrifle.png": "93923c5603ffa04770f564e445d69878",
"assets/assets/ingame/prisoner_efficiency.png": "b106814afb234b24d3ba69f8bdfcbe5f",
"assets/assets/ingame/revolver.png": "542a1274f84ec8f0652f38f6098e6d1c",
"assets/assets/ingame/rifle.png": "018515b32950cfe1b98cc32bfdc7f05e",
"assets/assets/ingame/sawedoffshotgun.png": "72e83b3d3e0858e7eb274eada5a2f637",
"assets/assets/ingame/scattergun.png": "cd2c7a3590c74b9476275c15abaa2ead",
"assets/assets/ingame/sector_main.png": "ec195529b55a3c50db231f4df4919cb1",
"assets/assets/ingame/sector_overload.png": "93d6a0258ebc8e366f540871162311b6",
"assets/assets/ingame/sector_secondary.png": "65a552ba865987096d289cb5d08a3aa8",
"assets/assets/ingame/shortrifle.png": "0e154f07977e4d5c0ab80387a95d38ef",
"assets/assets/ingame/shotgun.png": "419918b205becabb712f51e8a6c7f1b9",
"assets/assets/ingame/shotgunsentry.png": "647a2b223d4e45c692a078b7da87ed69",
"assets/assets/ingame/slugshotgun.png": "d93e043edd0d1b5e81136949008f7977",
"assets/assets/ingame/smg.png": "17256b2772317c7b54c289a2db253e58",
"assets/assets/ingame/sniper.png": "d07b591b9f5db4452000caff63ed9110",
"assets/assets/ingame/snipersentry.png": "74a76a45214bdbb39ca5a4c1afb0cb7e",
"assets/assets/ingame/spear.png": "9ea04a6169bc91ad52c807d01f7ff35d",
"assets/assets/ingame/woods.png": "7cb7ff9d7d5bcff3f28500b97206927b",
"assets/FontManifest.json": "fce5753403b38c4a51cf7541ce446a7c",
"assets/fonts/MaterialIcons-Regular.otf": "ea49f59ccdcdff872d97333f8d169ccd",
"assets/fonts/shared_tech/ShareTech-Regular.ttf": "1070bddc41a88e2b1745a34205d06c3d",
"assets/NOTICES": "4a631243be597ba1c4c5426bb713df6a",
"assets/packages/community_material_icon/fonts/materialdesignicons-webfont.ttf": "84c7bd136590da0a6ed2c21df180c354",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "fe4e6158e0621262a33d1f224cb56fe0",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "b6b453bb7f1e10f9b217c53b8a95853c",
"index.html": "fdf8eb95e6302ca85689431a41170524",
"/": "fdf8eb95e6302ca85689431a41170524",
"main.dart.js": "6b6484e0a0d2399c8a0ff1c3cfa9193f",
"manifest.json": "bfc6c8397b5e62254c068f062af1140c",
"site.webmanifest": "68808504d1d22a55416c0e3c8e59ac98",
"version.json": "b800482854414f1cbe4c8599b07c8aa3"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
