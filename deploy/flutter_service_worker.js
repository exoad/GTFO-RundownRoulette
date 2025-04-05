'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"android-chrome-192x192.png": "13308dac3f832a30a364ed6a1a819e50",
"android-chrome-512x512.png": "e4534be8b815c1f2c96ec2d58f0ecf44",
"apple-touch-icon.png": "6a6d583a428cd6d79943ee92bed4dc43",
"assets/AssetManifest.bin": "c82ce376df210e405dffa2a238bc00e8",
"assets/AssetManifest.bin.json": "bcf21ce5dd3cf56cb2b32e59c1ef009e",
"assets/AssetManifest.json": "c181c518e78a2fb2ff70b2dbf26109f1",
"assets/assets/icon.png": "b6d037e8aa6542dbeb816604e0f8a489",
"assets/assets/ingame/aggressive.png": "613ea870edfa8a45719de7b1a0962e3d",
"assets/assets/ingame/assaultrifle.png": "8dc6decfe357947213fa260cf1967153",
"assets/assets/ingame/autosentry.png": "e6e121a64789e832967a2838389d7186",
"assets/assets/ingame/bat.png": "bbbc749844765a0cb33751ba0f70bee4",
"assets/assets/ingame/biotracker.png": "4aa1492178e75bc24476aa2b35e88809",
"assets/assets/ingame/bishop.png": "2cb10f70d98a87c1a567d5883f4bf2c3",
"assets/assets/ingame/bold.png": "b9e295dd04242d658d51d9e19d28d406",
"assets/assets/ingame/bullpuprifle.png": "8aab6c064d830fc1984b0974c1c91685",
"assets/assets/ingame/burstcannon.png": "41d78453e8a225308d5c0182162b8c2e",
"assets/assets/ingame/burstpistol.png": "d9fc2701f44980a99c1683a8b41c1c12",
"assets/assets/ingame/burstrifle.png": "54887ee4a42e85edeca68d948996c559",
"assets/assets/ingame/burstsentry.png": "b9a09597bc7adcecd37b17ca042c1c0a",
"assets/assets/ingame/carbine.png": "9b8cc157eea1c21a6c09709bc12822a3",
"assets/assets/ingame/cfoam.png": "c494ef48644ac64f89909171e6a39f2b",
"assets/assets/ingame/chokemodshotgun.png": "2690e49a61478ed70a4551ee99c0d35a",
"assets/assets/ingame/combatshotgun.png": "d9d8aee1a02dc43a4b57f0ec3db087e6",
"assets/assets/ingame/dauda.png": "6f69c5c23a7467c5d16907847613c4e9",
"assets/assets/ingame/dmr.png": "2c7ce46ac02df60f0420d341feb6eb8a",
"assets/assets/ingame/doubletaprifle.png": "95719fc0e7ad49577f136a7b614d1ead",
"assets/assets/ingame/hackett.png": "db3eb300c9079d2056137776c31c75fe",
"assets/assets/ingame/hammer.png": "4e9171444ec996bc9c52df0e804851bc",
"assets/assets/ingame/heavyassaultrifle.png": "5eb47f821351b217daa04ebea9d09bc0",
"assets/assets/ingame/heavysmg.png": "e27280b9230e4575bfeff60a64a87968",
"assets/assets/ingame/helautopistol.png": "d016c1bd01ad6d9b6b4d9426caba6973",
"assets/assets/ingame/helgun.png": "dea11c8452561fcbc808d4462b9f5536",
"assets/assets/ingame/helrevolver.png": "7ae7e93f69c2c8b5f8aa4cb55891f967",
"assets/assets/ingame/helrifle.png": "aab0efe14b6d4407251ef1413b12e792",
"assets/assets/ingame/helshotgun.png": "55116c1a5887032651a853efc63f09d6",
"assets/assets/ingame/highcalpistol.png": "4818865c1547528dbacdf42850eb2186",
"assets/assets/ingame/knife.png": "fd200b50cec82b62ee160a33fa4d80f5",
"assets/assets/ingame/machinegunarbalist.png": "36e2cb7a0de7e84cea51ca13cf400304",
"assets/assets/ingame/machinegunveruta.png": "632a0ebea119a2688dde1f14b3f4bd72",
"assets/assets/ingame/machinepistol.png": "21735aeb50ebdf83680d49ee73a0bc8d",
"assets/assets/ingame/minedeployer.png": "0a34b676ff1de53130d1ec155f8024e0",
"assets/assets/ingame/muted.png": "98ea51f971f7f5f59df245fe837a33d6",
"assets/assets/ingame/pdw.png": "0b15240c41e4255d1d2e87e796f9f1ba",
"assets/assets/ingame/pistol.png": "59ee2d7f45907cc7635d00206ce04c6c",
"assets/assets/ingame/precisionrifle.png": "382568083b40ede29fb6782b71a98e6a",
"assets/assets/ingame/prisoner_efficiency.png": "b106814afb234b24d3ba69f8bdfcbe5f",
"assets/assets/ingame/revolver.png": "cb98949ad33d8e572eeb251601a4f659",
"assets/assets/ingame/rifle.png": "e39dfbe19b352d601ddc48f6957decf9",
"assets/assets/ingame/sawedoffshotgun.png": "4d8bb7d0950f72befbf48918dfd9a759",
"assets/assets/ingame/scattergun.png": "1e723aedbb4db769d5fc700bba3debad",
"assets/assets/ingame/sector_main.png": "ec195529b55a3c50db231f4df4919cb1",
"assets/assets/ingame/sector_overload.png": "93d6a0258ebc8e366f540871162311b6",
"assets/assets/ingame/sector_secondary.png": "65a552ba865987096d289cb5d08a3aa8",
"assets/assets/ingame/shortrifle.png": "00ded357ee60162fa43ad6aaf2620da4",
"assets/assets/ingame/shotgun.png": "f23efe8a75dbebc2784bff2bea6322a1",
"assets/assets/ingame/shotgunsentry.png": "7c73cfbff9fe67a66199bb18a032b63c",
"assets/assets/ingame/slugshotgun.png": "7fb37bd8a68f04d23c6d9f166e3f813d",
"assets/assets/ingame/smg.png": "08259ebc2944e74ffbb13b4f8a9ab0fd",
"assets/assets/ingame/sniper.png": "650fa186a2dfd825f76c3f2e85c6cd7a",
"assets/assets/ingame/snipersentry.png": "10ef5e0ff672433597ff3325d15192a0",
"assets/assets/ingame/spear.png": "9ea04a6169bc91ad52c807d01f7ff35d",
"assets/assets/ingame/woods.png": "7cb7ff9d7d5bcff3f28500b97206927b",
"assets/FontManifest.json": "4c1a47537125ef87e5e94bf0e992ab3d",
"assets/fonts/MaterialIcons-Regular.otf": "32421a6b5bb4272442bfdcb943ecf449",
"assets/fonts/shared_tech/ShareTech-Regular.ttf": "1070bddc41a88e2b1745a34205d06c3d",
"assets/NOTICES": "e25b6d9c26fe536af094035afe7f395a",
"assets/packages/community_material_icon/fonts/materialdesignicons-webfont.ttf": "84c7bd136590da0a6ed2c21df180c354",
"assets/packages/iconsax_flutter/fonts/FlutterIconsax.ttf": "83c878235f9c448928034fe5bcba1c8a",
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
"flutter_bootstrap.js": "4863072a9d6b81c30715e3555273e7f0",
"index.html": "25950f06ea5e5a113a2327b79a1159ad",
"/": "25950f06ea5e5a113a2327b79a1159ad",
"main.dart.js": "a9d02e9adc22d59d784d2019c72e2a47",
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
