'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "220a8301ece75ae03e5563fc669724b8",
"assets/AssetManifest.bin.json": "2a50a3b275e3da052e3cd6bff311cc96",
"assets/AssetManifest.json": "6e270298ddae0f8f614db001e3368b35",
"assets/assets/animations/success.json": "71c3bb0d637abf987dd6c20b7f1cf3ff",
"assets/assets/black_logo.svg": "8fe749623a3117201b4e8b935e7203cb",
"assets/assets/button.svg": "df1862fd42975afaaa25beeaee979e44",
"assets/assets/call.svg": "f9b69e18f45ef806b564aaddbd2b4943",
"assets/assets/cookie.svg": "47a80954802f77dbc1229e789d0f9d91",
"assets/assets/customer.svg": "20f70338fcc8aadadf5e2116b9181459",
"assets/assets/engagement.svg": "42e668f789f60cc37dfc6ed7bdac9e16",
"assets/assets/fonts/DancingScript-Bold.ttf": "6c5b41b0622681bb6aafb3d4ed2a1171",
"assets/assets/fonts/DancingScript-Regular.ttf": "949b41b511eeacbbf6884959b6eedc56",
"assets/assets/fonts/Roboto-Light.ttf": "25e374a16a818685911e36bee59a6ee4",
"assets/assets/fonts/Roboto-Regular.ttf": "303c6d9e16168364d3bc5b7f766cfff4",
"assets/assets/icons/captcha.png": "97de36e35493558f5c08ecaf072abbea",
"assets/assets/icons/customGoogleMarker.png": "93cb06b4b1e1fdb840aa70418d00fd8d",
"assets/assets/icon_button.svg": "f0fbf58265d861c45d98a05b2744cd12",
"assets/assets/images/aboutScreenWelcomeImage.webp": "664b32042919b5d3452526b1368f78b0",
"assets/assets/images/after.webp": "cdfe9a2b68bb56b21d807303776681ca",
"assets/assets/images/all.webp": "fd0ad4e89c393cae6bce1ae7c4f6df87",
"assets/assets/images/backgroundFeedbackSection.webp": "b550467b4ca7ff48e33141a97ec3a5d7",
"assets/assets/images/bathroom.webp": "e3f0a9ac31328368a4559edaabcc1fa8",
"assets/assets/images/before.webp": "ebd0c4d9f8a364e84beb3e9f3924cec4",
"assets/assets/images/building.webp": "eaa38d5c6a0d2ac7dba2441c8a4a64c7",
"assets/assets/images/carpenter.webp": "a227cd96fa36793550593d9a9976febe",
"assets/assets/images/contactAboutScreen.webp": "4a8b05644d175acb9ddf457fc948072c",
"assets/assets/images/contactScreenWelcomeImage.webp": "45308576946c135dcdf46245af366999",
"assets/assets/images/contactServicesScreen.webp": "de8617d04097eaeaf49da333e82c3175",
"assets/assets/images/drywallInstaller.webp": "4bf0714b113d7a4a90d05af2a00e35f7",
"assets/assets/images/electrician.webp": "cb26bd6a28ceba0272f768955c39116f",
"assets/assets/images/imageCompanyProfileSection.webp": "6911ef253c007f9ff2ab55aaac5202d6",
"assets/assets/images/kitchen.webp": "7fb0cdcc9c25675f5cd2075783ee56ed",
"assets/assets/images/landingScreenImage1.webp": "39a407c863d87acc1d95a7004a2f3251",
"assets/assets/images/landingScreenImage2.webp": "36474b553de4ac2f2e4b99845d510495",
"assets/assets/images/landingScreenImage3.webp": "27e78e1725173ce0b3e48f4062f887f5",
"assets/assets/images/landingScreenImage4.webp": "8bddedd7ae4bcaa77970520363da3e30",
"assets/assets/images/landingScreenImage5.webp": "c6468196b91f8e2cf7869912a8d5dcaa",
"assets/assets/images/landingScreenImage6.webp": "47d28135cab67bc5e344ff11380b9a5a",
"assets/assets/images/mason.webp": "453ac3192e1cd9ea7754b7289c928154",
"assets/assets/images/ourHistory.webp": "644f2b78c9feb009567bdeb906e7fac0",
"assets/assets/images/ourServices.webp": "f8ed09daa40e964663a4d0c27cd1b361",
"assets/assets/images/painter.webp": "c604f416f9a74eb7fa65b21f5c2a6db0",
"assets/assets/images/partialRenovation.webp": "5ea832b10772239e0c731c89c1d9663c",
"assets/assets/images/partnersScreenWelcomeImage.webp": "d9aa7805b77d32866eb4626a41f38800",
"assets/assets/images/plumber.webp": "1d6197f58469691ede02f14b7c932db3",
"assets/assets/images/projects/image1.webp": "003ad63767179033a0cc1a974c61f343",
"assets/assets/images/projects/image10.webp": "7a88c3cf9b29b01187f8645746f0f1ff",
"assets/assets/images/projects/image11.webp": "6a870986af584c438e3855b6e4667f20",
"assets/assets/images/projects/image12.webp": "21851da2b890f50be5de223f9b455298",
"assets/assets/images/projects/image13.webp": "ae3509ac7abd99541af58cd4dbf06dfc",
"assets/assets/images/projects/image14.webp": "2f7c0cb10e98ce2a20c0ac4f0bb56a47",
"assets/assets/images/projects/image15.webp": "19888b110882dd25e649c46e85636988",
"assets/assets/images/projects/image16.webp": "54d7ea597bdd61ee8e6c9cf20f9d2835",
"assets/assets/images/projects/image17.webp": "5d9d53e4f93568399106cfeb0c766d84",
"assets/assets/images/projects/image18.webp": "caf928a0b0c1e6244209376b9541e0cf",
"assets/assets/images/projects/image19.webp": "26285c4ffda062f234602334b9b1ca63",
"assets/assets/images/projects/image2.webp": "2b9bfcc513106b2b54d83fba613dd6cd",
"assets/assets/images/projects/image20.webp": "e422c1b64fd9ac7a10d6acfc8368230e",
"assets/assets/images/projects/image21.webp": "fb82a890611dae4fa21301946e38b48e",
"assets/assets/images/projects/image22.webp": "fa4347014f42790688d11a461d1b1b46",
"assets/assets/images/projects/image23.webp": "dac4d9caabb52864f00ab4ff33dfecc7",
"assets/assets/images/projects/image24.webp": "c3e4ff7ce5b42580e620b8f6bb1c281f",
"assets/assets/images/projects/image25.webp": "da702e324a8a2a56f67871388b6ce46c",
"assets/assets/images/projects/image26.webp": "792c0cf85edeb2719274e2235ec0c5e9",
"assets/assets/images/projects/image27.webp": "c752febf10052719e9d5497aa87425e7",
"assets/assets/images/projects/image28.webp": "a2721113b9c74ed0a3c1a98b5a25784f",
"assets/assets/images/projects/image29.webp": "0369e21b8c78caa1163c422e3efbbd7c",
"assets/assets/images/projects/image3.webp": "0e83e7ee0c530eb560ef062d96df7e2c",
"assets/assets/images/projects/image30.webp": "332bcf50c72e0e90c47d0a6a68980e1e",
"assets/assets/images/projects/image31.webp": "30861788d61872d8bdf4bb4134a33b51",
"assets/assets/images/projects/image32.webp": "f4bcf63d89949f20f933cf8a31b09eaf",
"assets/assets/images/projects/image33.webp": "f0fa42006276ff94960c605d685a90c7",
"assets/assets/images/projects/image34.webp": "95535fb23e582383f0b9c2c8aa5e3f67",
"assets/assets/images/projects/image35.webp": "86b74e933334f82e56a67a502132be07",
"assets/assets/images/projects/image36.webp": "8f6f3eacc694b93eee8721a2c76da124",
"assets/assets/images/projects/image37.webp": "3edc538ce61c9136659e7a96c2fd7dcb",
"assets/assets/images/projects/image38.webp": "a11f2d0b1575afa12b9d84bd5fce188f",
"assets/assets/images/projects/image39.webp": "6cfa99eba4ceec7669b58f14295eb9ca",
"assets/assets/images/projects/image4.webp": "db03a4496a71d27830109c79f7f18cd6",
"assets/assets/images/projects/image40.webp": "920900f1b0ffe1c3a02f5611c5ea5580",
"assets/assets/images/projects/image41.webp": "ded6753ed63b984d0b77a31030187edc",
"assets/assets/images/projects/image42.webp": "ddffb39447907ee2e0cd8ee7f67c0f4e",
"assets/assets/images/projects/image43.webp": "d748e5cda0e7ac31b8215b5fca7e2fb8",
"assets/assets/images/projects/image44.webp": "42705a4a347746f4a901e02948bac76c",
"assets/assets/images/projects/image45.webp": "9c98d0c29493a2363981e7532385d347",
"assets/assets/images/projects/image46.webp": "d4ebd162a8ef2a5218b7b6030afe0c19",
"assets/assets/images/projects/image47.webp": "2c668f816e1c3872c9d3e415b90910a4",
"assets/assets/images/projects/image48.webp": "71dab417e92fe7a0930c9cc8f7c1b04a",
"assets/assets/images/projects/image49.webp": "fd9aed0754dec68950163cdeba2dc27b",
"assets/assets/images/projects/image5.webp": "c91fa6729a936c90cef9fe3dc5753adc",
"assets/assets/images/projects/image50.webp": "c32b0ad92a59f6a40ddb789fd62c5af1",
"assets/assets/images/projects/image51.webp": "a6fde565db611682493bd16239abbd1e",
"assets/assets/images/projects/image52.webp": "00b46339cee9218ac54c704d20227117",
"assets/assets/images/projects/image53.webp": "7d8d218af7846dff453e48f0ba500c91",
"assets/assets/images/projects/image54.webp": "6c56bb1125d89ff3561548a05040676c",
"assets/assets/images/projects/image55.webp": "686eb0e966bb3d2e18a654fbf61f6916",
"assets/assets/images/projects/image56.webp": "b5becc26ad2ab0ab13d8b7f0a8027066",
"assets/assets/images/projects/image57.webp": "430e28ce09829a82f25df55b2a56518b",
"assets/assets/images/projects/image58.webp": "7aed0acc57fc5e810bf938a10ccc0b71",
"assets/assets/images/projects/image59.webp": "33da8618776e5086b024bfeeb3c70358",
"assets/assets/images/projects/image6.webp": "220b7ee45a7f1c5c05b0b95846cf7c7e",
"assets/assets/images/projects/image60.webp": "eae81e8c27edeab2b0f33f28d340ac36",
"assets/assets/images/projects/image61.webp": "7780a17b9034ba8a33992497223506af",
"assets/assets/images/projects/image62.webp": "1649b5df86d5ce723a755316b8124e97",
"assets/assets/images/projects/image63.webp": "cfb7e9afd549c577b8ddb0b364ce7fec",
"assets/assets/images/projects/image7.webp": "cf9783a2e9f249221e0978c211263d0c",
"assets/assets/images/projects/image8.webp": "015724aceb39a2dc88dc88f2492c5324",
"assets/assets/images/projects/image9.webp": "fefd75833b6270d6375dbad0bdfddd74",
"assets/assets/images/projects/thumbnails/image10_thumb.webp": "286cd2c3ba4977406b8c70127e29c449",
"assets/assets/images/projects/thumbnails/image11_thumb.webp": "540b3d4c61658c97a36f7e66b9033c11",
"assets/assets/images/projects/thumbnails/image12_thumb.webp": "d4a6933f11136adb98f4943c233f77c8",
"assets/assets/images/projects/thumbnails/image13_thumb.webp": "3cb1cf88a2a260e35204f3ff97312e32",
"assets/assets/images/projects/thumbnails/image14_thumb.webp": "1e8d46537ceedd07f3d75a4e01227310",
"assets/assets/images/projects/thumbnails/image15_thumb.webp": "0004a9fb6354d2dedd3a1cd526c8e18c",
"assets/assets/images/projects/thumbnails/image16_thumb.webp": "fc11616b0c31c4dfd94c2ed13a85ee69",
"assets/assets/images/projects/thumbnails/image17_thumb.webp": "f9bfe0b5f6b89cef98d82200897ef37e",
"assets/assets/images/projects/thumbnails/image18_thumb.webp": "721f5874274265b6c70ccbb7ce6b56fd",
"assets/assets/images/projects/thumbnails/image19_thumb.webp": "8a9d98ed4edbe260548c1ceb70fed729",
"assets/assets/images/projects/thumbnails/image1_thumb.webp": "d2cc86efa185bbe7646e02867b3da8d8",
"assets/assets/images/projects/thumbnails/image20_thumb.webp": "3853d2b0e912ce45d12c2a4cb0d6ca27",
"assets/assets/images/projects/thumbnails/image21_thumb.webp": "afbc4ab348567aa8ba8dee4ed84d6564",
"assets/assets/images/projects/thumbnails/image22_thumb.webp": "6741126fea0c4eb346f8ef2566f0f24b",
"assets/assets/images/projects/thumbnails/image23_thumb.webp": "6619d15611793c4494fced6975fe87f1",
"assets/assets/images/projects/thumbnails/image24_thumb.webp": "fbfd6bbf3712f957cddb43a5ee6e93e1",
"assets/assets/images/projects/thumbnails/image25_thumb.webp": "9c893cbc5e67538fdfc784fb699c816f",
"assets/assets/images/projects/thumbnails/image26_thumb.webp": "1c4fe3332394169cedd6ae85248077e8",
"assets/assets/images/projects/thumbnails/image27_thumb.webp": "be7cc7bd00f3f6657d7a0f6876ef2ea6",
"assets/assets/images/projects/thumbnails/image28_thumb.webp": "754882084b87b4a0e5600bd1cbe9f11a",
"assets/assets/images/projects/thumbnails/image29_thumb.webp": "52a99382e0c652ecd25887fdb577acbe",
"assets/assets/images/projects/thumbnails/image2_thumb.webp": "e701255f50014b63be53a38ce5c0c674",
"assets/assets/images/projects/thumbnails/image30_thumb.webp": "5770d7399caf6266b12747d023723fdd",
"assets/assets/images/projects/thumbnails/image31_thumb.webp": "6fe1cb00a4400f11357e27aa0f9e9bcb",
"assets/assets/images/projects/thumbnails/image32_thumb.webp": "94b4479344417835c6d66a66177642e0",
"assets/assets/images/projects/thumbnails/image33_thumb.webp": "231b9a42b6b40ae04f5cf828b45e9b1e",
"assets/assets/images/projects/thumbnails/image34_thumb.webp": "4b1ae6d868251ba1bbea01327f782331",
"assets/assets/images/projects/thumbnails/image35_thumb.webp": "ab2ef9e9e3d6192de2ea8ac9381ad675",
"assets/assets/images/projects/thumbnails/image36_thumb.webp": "2f87f1af9146a63beff10440daff64d8",
"assets/assets/images/projects/thumbnails/image37_thumb.webp": "807110e7de8113ca53537bfc836c6802",
"assets/assets/images/projects/thumbnails/image38_thumb.webp": "23af7997842c29f2c39b1fe27fade011",
"assets/assets/images/projects/thumbnails/image39_thumb.webp": "701542e5b6652eafa0ae6e7297c0f928",
"assets/assets/images/projects/thumbnails/image3_thumb.webp": "b389f55457b6fa2481fc16893de40bf6",
"assets/assets/images/projects/thumbnails/image40_thumb.webp": "174ae2e49c938d081745c28c7a03d50f",
"assets/assets/images/projects/thumbnails/image41_thumb.webp": "235f520f7e3150f22bfe76273d6636b5",
"assets/assets/images/projects/thumbnails/image42_thumb.webp": "5d9861b389656ca6ab928f56c3c9657b",
"assets/assets/images/projects/thumbnails/image43_thumb.webp": "31f73caa1f52bbf1fa6c245c99f1b1c9",
"assets/assets/images/projects/thumbnails/image44_thumb.webp": "3ce61c2ec0ed39cceb80962dcfb588ff",
"assets/assets/images/projects/thumbnails/image45_thumb.webp": "b4986a2016e8165ca9b21b9afdc2d55b",
"assets/assets/images/projects/thumbnails/image46_thumb.webp": "69c335fb792d0d47deaeae6dd7b50c9a",
"assets/assets/images/projects/thumbnails/image47_thumb.webp": "8008aa6754a98f71c2eee30aedbc00c9",
"assets/assets/images/projects/thumbnails/image48_thumb.webp": "a0d80d47b768849e495bdd11a50d5eaa",
"assets/assets/images/projects/thumbnails/image49_thumb.webp": "59f64382ea11d2db3aeee2d49a900b72",
"assets/assets/images/projects/thumbnails/image4_thumb.webp": "99226f742388464ebd0b1d21ef80c8e7",
"assets/assets/images/projects/thumbnails/image50_thumb.webp": "3ff5ae664e02d1b4148869eb027e4f31",
"assets/assets/images/projects/thumbnails/image51_thumb.webp": "0e1ecd629fa0c3bbb020ac4ab0052a59",
"assets/assets/images/projects/thumbnails/image52_thumb.webp": "550dfbe60a1fe652a1227cc8cfbdc7b9",
"assets/assets/images/projects/thumbnails/image53_thumb.webp": "484a82851b6487b8e71c7a0c9058196b",
"assets/assets/images/projects/thumbnails/image54_thumb.webp": "1d10ef834f6cf47bcf3d1b30815a51a8",
"assets/assets/images/projects/thumbnails/image55_thumb.webp": "fb7a4aa7ea829b68ea68e6b1888e5b1b",
"assets/assets/images/projects/thumbnails/image56_thumb.webp": "a4fe2d814b3e1258fda8789bf56f6c7f",
"assets/assets/images/projects/thumbnails/image57_thumb.webp": "596c568d6c9d52df229cf7294bacfcb4",
"assets/assets/images/projects/thumbnails/image58_thumb.webp": "b5a220ea1c74f38411d44d28b0c35a1d",
"assets/assets/images/projects/thumbnails/image59_thumb.webp": "737d9f551c0722625a628124c8cb7797",
"assets/assets/images/projects/thumbnails/image5_thumb.webp": "d6b7d097e020e3d3d465951296e6034f",
"assets/assets/images/projects/thumbnails/image60_thumb.webp": "352166d183bf9e986ca266e8e654584a",
"assets/assets/images/projects/thumbnails/image61_thumb.webp": "c891d64d4c625deb766a6dc9bed3dd9d",
"assets/assets/images/projects/thumbnails/image62_thumb.webp": "6607116f6a5552e34e6f28c04d5eca8b",
"assets/assets/images/projects/thumbnails/image63_thumb.webp": "a801834b76b7f638b1fdd283b3212d16",
"assets/assets/images/projects/thumbnails/image6_thumb.webp": "2b194bb2a74d1d53f703ab36a820a6fe",
"assets/assets/images/projects/thumbnails/image7_thumb.webp": "6a457442b58f9eb160b2eac6fe893a0a",
"assets/assets/images/projects/thumbnails/image8_thumb.webp": "74320c2d6bd2e661c6eaec77be182e47",
"assets/assets/images/projects/thumbnails/image9_thumb.webp": "d763e35f322e9767762c31739eaa52b8",
"assets/assets/images/projectsScreenWelcomeImage.webp": "426f9cd6d50510f4a20a636f3e3b3095",
"assets/assets/images/renovationAfterDisaster.webp": "76f8743c441f835ecc3e3801a30fb2ac",
"assets/assets/images/tiler.webp": "e6eeeeda8fa8e2fa88e88d358bd39adc",
"assets/assets/images/totalRenovation.webp": "446068b23c992a7efe932fa57fe0b63f",
"assets/assets/images/workTogether.webp": "019b6502fd59f38a857db886cd9610d4",
"assets/assets/quotationMarks.svg": "664e64114c25314f51d5c12afffd70cf",
"assets/assets/rive/call_us_button.riv": "424f6ff983557d8b0c1de161856129db",
"assets/assets/rive/company.riv": "5b966d8d257c99ab40fc967d1152e968",
"assets/assets/rive/contact_button%2520_with_reverse.riv": "a9560534e13fbb02408b6245d71e947e",
"assets/assets/rive/contact_button_v2.riv": "e0590a89fb7abced0418d1c6686cfb0d",
"assets/assets/rive/engagement.riv": "2b58d79b2de49b47bb553f6b318b4887",
"assets/assets/rive/free_quote_button.riv": "a2abd66c5412f39ba5d88bda21857947",
"assets/assets/rive/free_quote_button_v2.riv": "33757199c4d248c6625f48d3fcdcf26d",
"assets/assets/rive/sio2_renovations_splash.riv": "478687859dc36b5ae668e3bdf11148ca",
"assets/assets/rive/work_in_progress.riv": "071c3907b289a4524ef04845dec40e7b",
"assets/assets/structured.svg": "a832f1d4f8bb62cdc02788a9c4dfb046",
"assets/assets/white_logo.svg": "b933b92e31f54c94c5c5c473078a88f9",
"assets/FontManifest.json": "4f35eb35bffd8b40b567ec56808c0b3d",
"assets/fonts/MaterialIcons-Regular.otf": "1bb9265a52e5ebd1e8ce0c4386b35dd2",
"assets/local.env": "86dbb1489d85964bee1d72db2c39a158",
"assets/NOTICES": "24d9fde11688302e20e54e767e062ace",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4769f3245a24c1fa9965f113ea85ec2a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.ico": "c00d6688e8322e271cfc4c75a56f5c02",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "e0c78b31db20fc687cd026bcd463bd34",
"icons/apple-touch-icon.png": "15fa42a34e4df8e18fd3b90ac8b173b0",
"icons/cover.webp": "42894e2b874295d1701b76cbf73c0f40",
"icons/icon-192-maskable.png": "aa815fadd350db082e2a38da820b0bf6",
"icons/icon-192.png": "9180667f02206e258cce0c314ce4a7fe",
"icons/icon-512-maskable.png": "0e74ab7e1894fe207eb9d987e26bcce3",
"icons/icon-512.png": "d7efcdad65912876307535fd0870de25",
"index.html": "a3f0f3e4d8b0ac2af420346bb6573df5",
"/": "a3f0f3e4d8b0ac2af420346bb6573df5",
"llms.txt": "b67d01b3d05667e6adb37729e399b0e0",
"main.dart.js": "c02e4cbfdc13eb9367c71a85c2920170",
"manifest.json": "53b6f511dc83e63ab8a6cad163dad655",
"robots.txt": "6b9a6c8fee0f7134c35a29139deec000",
"version.json": "b60c2916c1952fe317332c86bbf26b2b"};
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
