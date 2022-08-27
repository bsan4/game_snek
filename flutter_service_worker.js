'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "d9609e6ad7f368210f36be50128770dc",
"index.html": "e9cf88c2ec891c1e6d4d17ff2b764fd5",
"/": "e9cf88c2ec891c1e6d4d17ff2b764fd5",
"main.dart.js": "02ec1d61a8b8743c3626853ec2d38d33",
"flutter.js": "eb2682e33f25cd8f1fc59011497c35f8",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "fb1fda109e4ded5156e41e76c1145ab2",
"assets/AssetManifest.json": "0bfd89d35d796f7946e6ec749ff617a6",
"assets/NOTICES": "65821abd0916a41f7049aaef575ce84d",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/images/background/Sans%2520titre-4.png": "c3d5b2988ed8fede8f78285ea8f71664",
"assets/assets/images/background/Sans%2520titre-3.png": "0d85fee5b233873678bf05975e1775d2",
"assets/assets/images/background/crabs.png": "a45d6c4e54ab06898b652791bb42e3dd",
"assets/assets/images/snakes/14.png": "6d1ea33d8608e50e7d4b09d474d4bc05",
"assets/assets/images/snakes/15.png": "8ef3099ff4ff6453e923785634e23804",
"assets/assets/images/snakes/playerBodyLeft.png": "d84c3833662113afd00767bffe323d1f",
"assets/assets/images/snakes/17.png": "b36bd4063bdd17d51d09d9d685a9980f",
"assets/assets/images/snakes/16.png": "486fb0de641f1a98c3721f9177ea39a1",
"assets/assets/images/snakes/13.png": "938c02aebd0142ddbc96b93f202f1d61",
"assets/assets/images/snakes/enemie.png": "241bf1209f49a039e21bf555efeab068",
"assets/assets/images/snakes/enemieBodyRight.png": "58b2649fd373145530a7ed92a6708dac",
"assets/assets/images/snakes/enemieBodyLeft.png": "e0a6da506fd6369c414946c780e99006",
"assets/assets/images/snakes/18.png": "dec2fe10b9c4b2a9f732d106917588aa",
"assets/assets/images/snakes/playerHead.png": "a06a0b4a1f7fa64098e4c6b5a4d2bab1",
"assets/assets/images/snakes/enemieHead.png": "7b6ee1f961360416403c8e04bbc0044e",
"assets/assets/images/snakes/playerBodyRight.png": "d679fdf1a346894e90570113af6a4fbc",
"assets/assets/images/snakes/player.png": "fd854a45a635c00384ef527bec085688",
"assets/assets/images/Ghostpixxells_pixelfood/68_macncheese_dish.png": "a643b71148444f442f24dfcad23a13a5",
"assets/assets/images/Ghostpixxells_pixelfood/53_gingerbreadman_dish.png": "5ae614d70fd391f4f77c8dbe1039706e",
"assets/assets/images/Ghostpixxells_pixelfood/19_burrito_dish.png": "ba0190686105b8b3717e8a65e5fc2810",
"assets/assets/images/Ghostpixxells_pixelfood/77_potatochips.png": "a9a88814f3c8bf175559054a731922a1",
"assets/assets/images/Ghostpixxells_pixelfood/97_sushi.png": "fdb06d1c839d1045a31b89ee6f76348b",
"assets/assets/images/Ghostpixxells_pixelfood/58_icecream_bowl.png": "50f11660f2133d04fd1efeecb408f169",
"assets/assets/images/Ghostpixxells_pixelfood/76_pudding_dish.png": "907b1e8a2b6f1798c5a9d9c1288fb92e",
"assets/assets/images/Ghostpixxells_pixelfood/48_garlicbread.png": "aef7859734b4fe56edc77b28800ef22a",
"assets/assets/images/Ghostpixxells_pixelfood/15_burger.png": "9c9e4225368e875d9f17e8e5501470b8",
"assets/assets/images/Ghostpixxells_pixelfood/56_hotdog_dish.png": "6f2a017b787b28dff46b54c6833cfe7b",
"assets/assets/images/Ghostpixxells_pixelfood/03_dish_pile.png": "0bab232047e1fdf9147c859ea6944141",
"assets/assets/images/Ghostpixxells_pixelfood/06_apple_pie_dish.png": "e2379b766e7dff3cac703f92dedd3cdf",
"assets/assets/images/Ghostpixxells_pixelfood/95_steak.png": "884db5ff356db1e95ac3b49e9494937c",
"assets/assets/images/Ghostpixxells_pixelfood/65_loafbread.png": "88eb9f8f513ea2843ae76c1badbd1b8a",
"assets/assets/images/Ghostpixxells_pixelfood/01_dish.png": "70abc184912a49fb01fc51255c5ebd19",
"assets/assets/images/Ghostpixxells_pixelfood/98_sushi_dish.png": "9ca45065846b6fd245acdf43b0a7db62",
"assets/assets/images/Ghostpixxells_pixelfood/80_pancakes_dish.png": "5b373ee4cb0855823a7c7c225d6988fa",
"assets/assets/images/Ghostpixxells_pixelfood/12_bun_dish.png": "b1f542773caffe7f69dcb910906daae1",
"assets/assets/images/Ghostpixxells_pixelfood/04_bowl.png": "017a45bd6773bc5ea5b41bbe552d5ae6",
"assets/assets/images/Ghostpixxells_pixelfood/31_chocolatecake_dish.png": "896e28b326ed919d1ec9aae56b894b70",
"assets/assets/images/Ghostpixxells_pixelfood/99_taco.png": "443db47a74edcfdf238f2cd8399c689c",
"assets/assets/images/Ghostpixxells_pixelfood/18_burrito.png": "b699df453eedace8c17db04f97c458ed",
"assets/assets/images/Ghostpixxells_pixelfood/83_popcorn.png": "1dabc5b585509894c2081bafde3457ce",
"assets/assets/images/Ghostpixxells_pixelfood/45_frenchfries_dish.png": "47c20c80141fb319c688d4441d845366",
"assets/assets/images/Ghostpixxells_pixelfood/74_omlet_dish.png": "0803233a93b731addcc8f3d09c32afaa",
"assets/assets/images/Ghostpixxells_pixelfood/30_chocolatecake.png": "e265b26fadaaead4ffe5e6cca5986918",
"assets/assets/images/Ghostpixxells_pixelfood/52_gingerbreadman.png": "1b20b13b1d89a3ff7cf454b80771bbee",
"assets/assets/images/Ghostpixxells_pixelfood/90_strawberrycake.png": "3faa800010ba66d19d72d33d0dd2ac02",
"assets/assets/images/Ghostpixxells_pixelfood/70_meatball_dish.png": "20afa040088016899d87de9886839224",
"assets/assets/images/Ghostpixxells_pixelfood/84_popcorn_bowl.png": "0f416720fc9c0871ed6a787f7ec8207e",
"assets/assets/images/Ghostpixxells_pixelfood/44_frenchfries.png": "3633123c0dd94e0cdce316100c26150d",
"assets/assets/images/Ghostpixxells_pixelfood/67_macncheese.png": "e1abb6fbd46c5b1dd0501bf614706c71",
"assets/assets/images/Ghostpixxells_pixelfood/78_potatochips_bowl.png": "124bf6cec9e998eccfe76e0e88101010",
"assets/assets/images/Ghostpixxells_pixelfood/29_cookies_dish.png": "dd66f497ba718a3751e92dbaec9afcec",
"assets/assets/images/Ghostpixxells_pixelfood/36_dumplings.png": "66cf6e418c72582c5aad53b7c0de8f85",
"assets/assets/images/Ghostpixxells_pixelfood/38_friedegg.png": "6deae5a6f3ed65025f26e7c935158ee2",
"assets/assets/images/Ghostpixxells_pixelfood/16_burger_dish.png": "46ed3ee23d5613bb0ac9f9f154126422",
"assets/assets/images/Ghostpixxells_pixelfood/101_waffle.png": "93d7b4bf9e10651435137399f4b7754b",
"assets/assets/images/Ghostpixxells_pixelfood/71_nacho.png": "da453cfd84a502d3d8f5964eccafa13c",
"assets/assets/images/Ghostpixxells_pixelfood/11_bun.png": "71d8f764678869d52ec6c17580870724",
"assets/assets/images/Ghostpixxells_pixelfood/49_garlicbread_dish.png": "1131bd59ca4885d1ac6dd569e6d4dc5a",
"assets/assets/images/Ghostpixxells_pixelfood/25_cheesepuff_bowl.png": "90d73a07adf6bdff7033a157ca234e92",
"assets/assets/images/Ghostpixxells_pixelfood/69_meatball.png": "0fbd43f2c0f7c025e2ca23125788446b",
"assets/assets/images/Ghostpixxells_pixelfood/79_pancakes.png": "9374f5bc4b679a6ed41f4663321a8e60",
"assets/assets/images/Ghostpixxells_pixelfood/23_cheesecake_dish.png": "491699e5a203ba7ebf2fb33210e2dc2f",
"assets/assets/images/Ghostpixxells_pixelfood/07_bread.png": "e09bfeea51703bc5775cc0cf365375d0",
"assets/assets/images/Ghostpixxells_pixelfood/59_jelly.png": "d9209d8bfaf90c8aa019470404af5c38",
"assets/assets/images/Ghostpixxells_pixelfood/85_roastedchicken.png": "e7560bef95fb3b847105c34d31cefe4f",
"assets/assets/images/Ghostpixxells_pixelfood/21_bagel_dish.png": "adf3c058ea98bcb8186e97bec7eccd5c",
"assets/assets/images/Ghostpixxells_pixelfood/10_baguette_dish.png": "1a93b71cfde9204e9e45750607fd9026",
"assets/assets/images/Ghostpixxells_pixelfood/81_pizza.png": "127109a67bb6aad476d5995c61d63d34",
"assets/assets/images/Ghostpixxells_pixelfood/24_cheesepuff.png": "4fa2754adf6fd8fc17e42c097fa5e013",
"assets/assets/images/Ghostpixxells_pixelfood/73_omlet.png": "2446c040ef9f301358686b5f76afefd0",
"assets/assets/images/Ghostpixxells_pixelfood/46_fruitcake.png": "2e3ad8cd7a57b7bde4a9ab913f18744c",
"assets/assets/images/Ghostpixxells_pixelfood/55_hotdog_sauce.png": "831e2abef2a58399124f573622bfee55",
"assets/assets/images/Ghostpixxells_pixelfood/34_donut.png": "28ff3746471d0e93e179510d80502af4",
"assets/assets/images/Ghostpixxells_pixelfood/13_bacon.png": "08add771a538cd79a2c47bfb8383d3af",
"assets/assets/images/Ghostpixxells_pixelfood/94_spaghetti.png": "000d8aa09a399b1d78584d84ef0a01fa",
"assets/assets/images/Ghostpixxells_pixelfood/57_icecream.png": "1b446cbfca912ecfb8d739fba32a6d46",
"assets/assets/images/Ghostpixxells_pixelfood/02_dish_2.png": "f330a5d54d4edeea8ab57b9570eec9b4",
"assets/assets/images/Ghostpixxells_pixelfood/66_loafbread_dish.png": "84eba92e4d22f4f551647db5e436dc76",
"assets/assets/images/Ghostpixxells_pixelfood/60_jelly_dish.png": "7f4554d2430e0fca6166c982d95b23c4",
"assets/assets/images/Ghostpixxells_pixelfood/93_sandwich_dish.png": "a50edd9804d3be84ba9355e8c03562ad",
"assets/assets/images/Ghostpixxells_pixelfood/96_steak_dish.png": "772c22db2b89e7e08095ef055f0474b4",
"assets/assets/images/Ghostpixxells_pixelfood/41_eggsalad_bowl.png": "d8abdd56c5bd1600d964be500695355b",
"assets/assets/images/Ghostpixxells_pixelfood/102_waffle_dish.png": "28d9351038317d34a2c26c6bf2413f76",
"assets/assets/images/Ghostpixxells_pixelfood/89_salmon_dish.png": "14c12610ea873a54746795e362181def",
"assets/assets/images/Ghostpixxells_pixelfood/05_apple_pie.png": "85139570ce594a896696f66c3a39477d",
"assets/assets/images/Ghostpixxells_pixelfood/39_friedegg_dish.png": "db6e2a9dbca08a973060c8c26bea5ede",
"assets/assets/images/Ghostpixxells_pixelfood/72_nacho_dish.png": "39f3e0e96808c61fee54b4e56bea1ed4",
"assets/assets/images/Ghostpixxells_pixelfood/100_taco_dish.png": "afe0458a23a618687e8862c944a41b17",
"assets/assets/images/Ghostpixxells_pixelfood/37_dumplings_dish.png": "9b0646bd7afa547720d08de36857b4d4",
"assets/assets/images/Ghostpixxells_pixelfood/50_giantgummybear.png": "e85210808c4585d9add5df31a7ef7626",
"assets/assets/images/Ghostpixxells_pixelfood/92_sandwich.png": "31f16798c98274263242775cacb79643",
"assets/assets/images/Ghostpixxells_pixelfood/35_donut_dish.png": "69083f58d3b3d369d1d752b933e554e3",
"assets/assets/images/Ghostpixxells_pixelfood/42_eggtart.png": "6fbed63062ef6a8f03f30e73b39fd7ed",
"assets/assets/images/Ghostpixxells_pixelfood/75_pudding.png": "b44b86248da6fb0b9ecbf5b7b23decab",
"assets/assets/images/Ghostpixxells_pixelfood/40_eggsalad.png": "2cf1a1b54d039a81af6def580c133a12",
"assets/assets/images/Ghostpixxells_pixelfood/28_cookies.png": "1b76824aad956dd51120ae33da4701ab",
"assets/assets/images/Ghostpixxells_pixelfood/43_eggtart_dish.png": "94efc3237eabdb59284ae0a9ad61b670",
"assets/assets/images/Ghostpixxells_pixelfood/54_hotdog.png": "a7abcb45443f745804374d842ce76233",
"assets/assets/images/Ghostpixxells_pixelfood/64_lemonpie_dish.png": "9f9a5af6c195849a8567762baf89d855",
"assets/assets/images/Ghostpixxells_pixelfood/20_bagel.png": "74887631d997ae8eb12164ee817badc6",
"assets/assets/images/Ghostpixxells_pixelfood/91_strawberrycake_dish.png": "0c5ffe53d08105634acfb1edbcb424d2",
"assets/assets/images/Ghostpixxells_pixelfood/61_jam.png": "2b5c12bcfb7679fa9e19d1dcfae80e3e",
"assets/assets/images/Ghostpixxells_pixelfood/17_burger_napkin.png": "f70bac4a23c59b16200084e902415c92",
"assets/assets/images/Ghostpixxells_pixelfood/88_salmon.png": "4835132800eada9a1fe8164ab5dd68f4",
"assets/assets/images/Ghostpixxells_pixelfood/47_fruitcake_dish.png": "829361a1b552cc2a72adc2ff3c21813b",
"assets/assets/images/Ghostpixxells_pixelfood/86_roastedchicken_dish.png": "1fd79b7e1505aa3d33540896722eef52",
"assets/assets/images/Ghostpixxells_pixelfood/27_chocolate_dish.png": "017e3fe09a31288a46d430f13750c261",
"assets/assets/images/Ghostpixxells_pixelfood/09_baguette.png": "9d8e8538feb535e1509c83f2b4db28a8",
"assets/assets/images/Ghostpixxells_pixelfood/32_curry.png": "8f2f863dad4dbbe4d635913b0cf07d1d",
"assets/assets/images/Ghostpixxells_pixelfood/14_bacon_dish.png": "fa009c06cd722e2d51dca63d33886304",
"assets/assets/images/Ghostpixxells_pixelfood/51_giantgummybear_dish.png": "7f37352d4fa05beea5920493969bce60",
"assets/assets/images/Ghostpixxells_pixelfood/26_chocolate.png": "eeb6597b158d4e89a23f273e12ca3cc3",
"assets/assets/images/Ghostpixxells_pixelfood/08_bread_dish.png": "d7d5315a8f5dbb5af65b4e2f87cccc34",
"assets/assets/images/Ghostpixxells_pixelfood/22_cheesecake.png": "0e9d39a759ec571f483882838ce7a31c",
"assets/assets/images/Ghostpixxells_pixelfood/82_pizza_dish.png": "06531372930d536efa69a6104cd7a511",
"assets/assets/images/Ghostpixxells_pixelfood/87_ramen.png": "df1ca8d2cf57a5cf6fd0d9ade1ff2768",
"assets/assets/images/Ghostpixxells_pixelfood/62_jam_dish.png": "69bf88f7635380a52cdd77e21f256998",
"assets/assets/images/Ghostpixxells_pixelfood/63_lemonpie.png": "243a09c23cc45fc62d9792f5f5b5ce6c",
"assets/assets/images/Ghostpixxells_pixelfood/33_curry_dish.png": "73567826257a567cea14fbfabf0aed6c",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
