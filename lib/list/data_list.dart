  //unit list
  List values = ["Aana","Kattha","Square Meter"];

  //rate list
  List weightedRatio = ["50% - 50%","60% - 40%","70% - 30%","80% - 20%","90% - 10%"];
  List distressRatio = ["10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%",];

  var data1 = [
  'Ropani',
  'Anna',
  'Paisa',
  'Dam'
];

var data2 = [
  'Bigha',
  'Kattha',
  'Dhur',
  'More'
];

var mulyankanNirdeshanNepali = [
  "जमिनको स्वामित्व तथा हस्तान्तरण सम्बन्धी कागजातहरु जस्तै लालपुर्जा, बकसपत्र, छोडपत्र, अंशवण्डा, राजिनामाका कागजातहरु।",
  "नापी कार्यालयबाट प्रमाणित गरिएको जग्गाको नापी नक्शा, ब्लुप्रिन्ट।",
  "सम्बन्धित वडा कार्यालयको चार किल्ला प्रमाणित पत्र।",
  "तिरो तिरेको रसिद।",
  "जग्गाधनीको कानुनी हकदारहरु खुलेको तथा तिनीहरुको मञ्जुरी पत्र।",
  "नगर विकासको योजनाभित्रको जग्गा भएमा उक्त जग्गा बाटोमा नपर्ने भन्ने सिफारिस पत्र।",
];
var mulyankanNirdeshanEnglish = [
  "Documents related to ownership and transfer of land such as Lalpurja, Baksapatra, Chod Patra, Anshabanda, Rajinama documents.",
  "Land Survey Blueprint, Blueprint certified by Surveyors Office.",
  "Four fort(4 Killa) certified letter from the concerned ward office.",
  "Your payment receipt.",
  "Disclosure of the legal rights of the land owner and their consent letter.",
  "A letter of recommendation that if the land is within the urban development plan, the said land should not fall on the road.",
];

var bankSurachyanNepali = [
  "नाबालकको नामको घर, घडेरी तथा जग्गा।",
  "आवास तथा ब्यापारिक प्रयोजन को लागी उपयुक्त नभएको घर, घडेरी तथा जग्गा जस्तोः भीर पाखा को जग्गा।",
  "आवत जावत गर्ना स्वतन्त्र निर्विवाद तथा उपयुक्त बातो नभएको घर, घडेरी तथा जग्गा।",
  "विद्युतको ३२ के.भी. वा सोभन्दा बढीको Hight Tension Line भएको जग्गा र त्यसको १५ मिटरभित्रको जग्गा।",
  "विद्युतको ३२ के.भी. भन्दा कमको High Tension Line भएको जग्गा र त्यसको २ मिटरभित्रको जग्गा।",
  "गुठीमा दर्ता भएको घर जग्गा।",
  "नामसारी गरिएको हदम्याद पुरा नभएको जग्गा जस्तै राजिनामाबाट आएको जग्गाको हकमा ६ महिना ३५ दिन।",
  "बकसपत्रबाट आएको जग्गाको २ बर्ष ३५ दिन।",
  "अंशवण्डाबाट आएको जग्गाको ३ महिना कानुनी हदम्याद पुरा नभएको जग्गा।",
  "घर जग्गा राजिनामाबाट खरिदमा विक्रेताको सबै हकवालालाई साक्षी राखि उक्त धितो स्विकार गर्न सकिनेछ ।",
  "मोटरेवल बाटो नभएको अवस्थामा केन्द्रिय कार्यालयबाट स्विकृति लिनुपर्नेछ।",
];

var bankSurachyanEnglish = [
  "House, property and land in the name of the minor.",
  "Houses, buildings and land not suitable for residential and commercial purposes such as: Bhir Pakha land.",
  "Houses, buildings and land without free movement and undisputed and suitable roads.",
  "Land with 32 kV electrical Hight Tension Line or more and land within 15 meters.",
  "Land with 32 kV electrical High Tension Line less than and land within 2 meters.",
  "Real estate registered in Guthi.",
  "6 months and 35 days in case of land that has not been registered, such as land that came from resignation.",
  "2 years and 35 days of land from Baksapatra.",
  "The land that came from Anshabanda has not reached the 3 month legal limit.",
  "In the purchase of real estate by resignation, the mortgage can be accepted by keeping all the rights of the seller as witnesses.",
  "In case there is no motorable road, approval must be taken from the central office.",
];

var jaggaMulyankanAdhaarCityNepali = [
  {
    "place" : "महानगरपालिका, उपमहानगरपालिका र नगरपालिका",
    "services" : "प्रमुख ब्यापारिक केन्द्रमा प्रमुख ब्यापारिक सडकसंग जोडिएको",
    "valueToMaintain" : "चलनचल्ती मुल्यको ८०% र मालपोत कार्यालयको २०% भार दिई",
  },
  {
    "place" : "महानगरपालिका, उपमहानगरपालिका र नगरपालिका",
    "services" : "ब्यापारिक केन्द्र (मोटरेवल सडक, विजुली, टेलिफोन, बजार जस्ता सुविधाहरु भएको)",
    "valueToMaintain" : "चलनचल्ती मुल्यको ७०% र मालपोत कार्यालयको ३०% भार दिई",
  },
  {
    "place" : "महानगरपालिका, उपमहानगरपालिका र नगरपालिका",
    "services" : "मोटरेवल सडक, विजुली, टेलिफोन, बजार जस्ता सुविधाहरु भएको सडकसंग जोडिएको ब्यापारिक, आवासीय केन्द्र",
    "valueToMaintain" : "चलनचल्ती मुल्यको ६५% र मालपोत कार्यालयको ३५% भार दिई",
  },
  {
    "place" : "महानगरपालिका, उपमहानगरपालिका र नगरपालिका",
    "services" : "मोटर चल्ने सडकबाट बढीमा २०० मिटरसम्मभित्र अवस्थित गोरेटो बाटो भएको बाक्लो आवास क्षेत्र",
    "valueToMaintain" : "चलन चल्तीको मूल्यको ५०% र मालपोत कार्यालयको मूल्यको ५०% भार दिई",
  }
];

var jaggaMulyankanAdhaarCityEnglish = [
  {
    "place" : "Metropolitan Municipality, Sub-Metropolitan Municipality and Municipality",
    "services" : "Connected to major commercial roads in major commercial centers",
    "valueToMaintain" : "80% of the customs value and 20% of the shipping office",
  },
  {
    "place" : "Metropolitan Municipality, Sub-Metropolitan Municipality and Municipality",
    "services" : "Business center (with facilities like motor road, electricity, telephone, market)",
    "valueToMaintain" : "70% of the customs value and 30% of the shipping office",
  },
  {
    "place" : "Metropolitan Municipality, Sub-Metropolitan Municipality and Municipality",
    "services" : "A business, residential center connected to the road with facilities like motor road, electricity, telephone, market",
    "valueToMaintain" : "65% of the customs value and 35% of the shipping office",
  },
  {
    "place" : "Metropolitan Municipality, Sub-Metropolitan Municipality and Municipality",
    "services" : "A dense residential area with narrow roads located within a maximum of 200 meters from a motorable road",
    "valueToMaintain" : "50% of the customs value and 50% of the customs office value",
  }
];

var jaggaMulyankanAdhaarVillageNepali = [
  {
    "place" : "गा.वि.स.",
    "services" : "पानी, बत्ती, टेलिफोन, यातायात सुविधा जस्ता पुर्वाधारहरु भएको र नगरपालिकासंग जोडिएको ब्यापारिक र आवासीय क्षेत्र",
    "valueToMaintain" : "चलनचल्ती मुल्यको ६०% र मालपोत कार्यालयको ४०% भार दिई",
  },
  {
    "place" : "गा.वि.स.",
    "services" : "पानी, बत्ती, टेलिफोन, मोटर चल्ने पिच÷ग्राभेल बाटो जस्ता पुर्वाधार भएको बजार क्षेत्र",
    "valueToMaintain" : "चलनचल्ती मुल्यको ६०% र मालपोत कार्यालयको ४०% भार दिई",
  },
  {
    "place" : "गा.वि.स.",
    "services" : "सामान्य वस्ती र गाडी चल्ने बाटो भएको घडेरी जग्गा",
    "valueToMaintain" : "चलनचल्ती मुल्यको ५०% र मालपोत कार्यालयको ५०% भार दिई",
  },
  {
    "place" : "गा.वि.स.",
    "services" : "गाउँमा अवस्थित गाडी चल्ने बाटो भएको कृषि योग्य जग्गा",
    "valueToMaintain" : "चलनचल्ती मुल्यको ५०% र मालपोत कार्यालयको ५०% भार दिई",
  }
];

var jaggaMulyankanAdhaarVillageEnglish = [
  {
    "place" : "Village Development Comitee",
    "services" : "Commercial and residential areas with infrastructure such as water, electricity, telephone, transport facilities and connected to the municipality",
    "valueToMaintain" : "60% of the customs value and 40% of the shipping office",
  },
  {
    "place" : "Village Development Comitee",
    "services" : "Market area with basic infrastructure like water, electricity, telephone, motorable pitch/gravel road",
    "valueToMaintain" : "60% of the customs value and 40% of the shipping office",
  },
  {
    "place" : "Village Development Comitee",
    "services" : "Ghaderi land with normal habitation and vehicular road",
    "valueToMaintain" : "50% of the customs value and 50% of the shipping office",
  },
  {
    "place" : "Village Development Comitee",
    "services" : "Agricultural land with driveway located in village",
    "valueToMaintain" : "50% of the customs value and 50% of the shipping office",
  }
];

var guideLines = [
  {
    "title" : "खोला नाला",
    "content" : "वाग्मती, विष्णुमती र मनोहराको दायाँ वायाँ खोला छेउबाट २० मिटर बाहिर पर्ने जग्गा, खोलानाला, खहरे आदि संग नसटेको पहाडी ईलाकाको घर, जग्गा तथा खोलानाला, खहरे आदिबाट २०० फिट भन्दा टाढा रहेको तराई क्षेत्रको घर, जग्गा अन्य जग्गाको हकमा स्थानिय तहको राजपत्रमा प्रकाशित मापदण्ड भित्र नपरेका जग्गा धितो सुरक्षण गर्न योग्य हुने छन् ।"
  },
  {
    "title" : "विद्युत्तिय लाईन",
    "content" : "विद्युतको ३३ के.भी. वा सोभन्दा बढीको  High Tension Line भएको जग्गा र सो Line को ५ मिटरसम्मको जग्गा, विद्युतको ३३ के.भी. भन्दा कमका High Tension Line भएको जग्गा र सो Line को २ मिटरसम्मको जग्गा । यदि यस्ता विद्युत Line धितोको बिचबाट गएको रहेछ भने उल्लेखित मापदण्ड कटाएर बाँकी धितोको मूल्याङ्कन गरिन्छ ।"
  },
  {
    "title" : "स्बामित्व",
    "content" : "धितो सुरक्षण गर्न योग्य हुने जग्गाहरुः \n\nक)  कानूनी स्वामित्व स्पष्ट भएका घर, घडेरी तथा जग्गा । \n\nख)  नामसारी गरिएको हदम्याद पुरा भएको जग्गा जस्तै राजिनामाबाट आएको जग्गाको हकमा ६ महिना ३५ दिन, बकसपत्रबाट आएको जग्गाको २ बर्ष ३५ दिन तथा अंशवण्डाबाट आएको जग्गाको ३ महिना कानुनी हदम्याद पुरा भएको जग्गा तर घर जग्गा राजिनामाबाट भएको खरिदमा विक्रेताको सबै हकवालालाई साक्षी राखि उक्त धितो स्विकार गर्न सकिनेछ \n\nग)  सार्वजनिक रुपमा वा जनसमुदायको हितको लागि प्रयोग नभैरहेको जग्गा । \n\nघ)  कित्ता नम्बर, साँध–सँधियार एवं क्षेत्रफल स्पष्ट खुलेको घर, घडेरी तथा जग्गा र यस्ता क्षेत्रमा अवस्थित घर, घडेरी तथा जग्गा । \n\nङ)  नावालकको नामको नाममा नरहेको घर, घडेरी तथा जग्गा । \n\nच)  सरकारी गुठीमा दर्ता नभएको घर जग्गा तथा मिति २०६४/१०/१० भन्दा अगाडी गुठीबाट रैतानी भई आएका घरजग्गाहरु । \n\nख)  मोही नलागेको जग्गा ।"
  },
  {
    "title" : "बाटो सम्बन्धि",
    "content" : "आवत जावत गर्न स्वतन्त्र, निर्विवाद तथा उपयुक्त बाटो भएको घर, घडेरी तथा जग्गा धितो सुरक्षण गर्न योग्य हुने छन् । बाटो भन्नाले कम्तीमा ८ फिट चौडाइ भएको मोटरेवल बाटो बुझाउनेछ । नापी नक्सामा बाटो नदेखिएको जग्गाको हकमा भौतिक पूर्वाधार सुविधाहरु उपलब्ध रहेको र कम्तिमा विगत ३ वर्षदेखि उक्त जग्गामा आवत जावत गर्ने सार्बजनिक सडक बाटो रहेको व्यहोरा उल्लेख गरी सम्बन्धित स्थानीय तहले प्रमाणित गरेमा उक्त जग्गा धितो सुरक्षणको रुपमा लिन सकिनेछ ।"
  },
  {
    "title" : "आवश्यक कागजात",
    "content" : "क)  जमिनको स्वामित्व तथा हस्तान्तरण सम्बन्धी कागजातहरु जस्तै जग्गाधनी दर्ता प्रमाण पत्र, बैंकको पत्रबाट बैंक कै कर्मचारीबाट उतार गरी ल्याएको जग्गा दर्ता श्रेस्ता (फिल्डबुक), बकसपत्र, छोडपत्र, अंशवण्डा, राजिनामा आदि कागजातहरु । \n\nख)  नापी कार्यालयबाट बैंकको पत्रबाट बैंक कै कर्मचारीबाट उतार गरीप्रमाणित गरिएको जग्गाको नापी नक्सा, ट्रेस नक्सा, ब्लुप्रिन्ट । \n\nग)  सम्बन्धित वडा कार्यालयको चार किल्ला प्रमाणित पत्र । \n\nघ) स्थानीय तहमा मालपोत/तिरो तिरेको वा एकिकृत सम्पति कर तिरेको रसिद । \n\nङ)  प्रस्तावित धितो हाल रोक्का रहे/नरहेको विवरण । \n\nच)  तेस्रो पक्षको धितो (घर जग्गा) को हकमा कानूनी हकदार खुलेको विवरण तथा निजहरुको लिखित मञ्जुरीनामा । कर्जा रकम बढेको अवस्थामा नयाँ मञ्जुरीनामा लिनुपर्नेछ । \n\nछ)  जग्गाधनीको कानूनी हकदारहरु खुलेको विवरण तथा तिनीहरुको मञ्जुरी पत्र । \n\nज)  नापी नक्सामा बाटो नदेखिएको जग्गाको हकमा भौतिक पूर्वाधार सुविधाहरु उपलब्ध रहेको र कम्तिमा विगत ३ वर्षदेखि उक्त जग्गामा आवत जावत गर्ने सार्बजनिक सडक बाटो रहेको व्यहोरा उल्लेख गरी सम्बन्धित स्थानीय तहले प्रमाणित गरेमा उक्त जग्गा धितो सुरक्षणको रुपमा लिन सकिनेछ । \n\nझ)  नगर विकासको योजनाभित्रको जग्गा भएमा उक्त जग्गा बाटोमा नपर्ने भन्ने सिफारिस पत्र ।"
  },
];


var termAndConditions = [
  "Valuation norms and guidelines may differ for each bank.",
  "This app provides general information about land value within Nepal.",
  "The result cannot be presented for any official purpose."
];
