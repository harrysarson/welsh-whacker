module Content.Tmp exposing (..)

import Content.WelshPlaces exposing (..)


getInfo : Place -> Info
getInfo place =
    case place of
        -- Amlwch ->
        --     { name = "Amlwch"
        --     , blurb = Nothing "Amlwch"
        --     , wikipedia = "Amlwch"
        --     }
        -- Beaumaris ->
        --     { name = "Beaumaris"
        --     , blurb = Nothing "Beaumaris"
        --     , wikipedia = "Beaumaris"
        --     }
        -- Benllech ->
        --     { name = "Benllech"
        --     , blurb = Nothing "Benllech"
        --     , wikipedia = "Benllech"
        --     }
        -- Holyhead ->
        --     { name = "Holyhead"
        --     , blurb = Nothing "Holyhead"
        --     , wikipedia = "Holyhead"
        --     }
        Llanfairpwllgwyngyll ->
            { name = "Llanfairpwllgwyngyll"
            , blurb = "A small town with a big name, Llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch (or Llanfairpwllgwynygall for short) is a must-visit if you're all about twenty-foot place names."
            , wikipedia = "Llanfairpwllgwyngyll"
            }

        Llangefni ->
            { name = "Llangefni"
            , blurb = "Llangefni is a charming island town and the Welsh core of Angelsey: 4 in 5 residents are Welsh speakers! Its Oriel Ynys Mon museum chronicles the history, culture and crafts of the whole island."
            , wikipedia = "Llangefni"
            }

        -- MenaiBridge ->
        --     { name = "Menai Bridge"
        --     , blurb = Nothing "Menai_Bridge"
        --     , wikipedia = "Menai_Bridge"
        --     }
        -- Ammanford ->
        --     { name = "Ammanford"
        --     , blurb = Nothing "Ammanford"
        --     , wikipedia = "Ammanford"
        --     }
        -- BurryPort ->
        --     { name = "Burry Port"
        --     , blurb = Nothing "Burry_Port"
        --     , wikipedia = "Burry_Port"
        --     }
        -- Carmarthen ->
        --     { name = "Carmarthen"
        --     , blurb = Nothing "Carmarthen"
        --     , wikipedia = "Carmarthen"
        --     }
        -- Garnant ->
        --     { name = "Garnant"
        --     , blurb = Nothing "Garnant"
        --     , wikipedia = "Garnant"
        --     }
        -- Glanamman ->
        --     { name = "Glanamman"
        --     , blurb = Nothing "Glanamman"
        --     , wikipedia = "Glanamman"
        --     }
        Kidwelly ->
            { name = "Kidwelly"
            , blurb = "Kidwelly is the lair of a great, grey beast of a castle. Built, attacked and rebuilt for the first two centuries of its life, the current structure of Kidwelly Castle dates all the way back to the 1270s."
            , wikipedia = "Kidwelly"
            }

        Laugharne ->
            { name = "Laugharne"
            , blurb = "Laugharne lies in the shadows of a Norman castle and the late, great Dylan Thomas. A pilgrimage site – Thomas' boathouse and tombstone are visitor hotspots – and sleepy Georgian town, Laugharne has also been immortalised by one of Britain's greatest painters: JMW Turner, who took inspiration from the castle's prospect above the salt marshes."
            , wikipedia = "Laugharne"
            }

        -- Llandeilo ->
        --     { name = "Llandeilo"
        --     , blurb = Nothing "Llandeilo"
        --     , wikipedia = "Llandeilo"
        --     }
        Llandovery ->
            { name = "Llandovery"
            , blurb = "Lovely Llandovery has a lovely name: it means ‘the church among the waters’. A scenic town to explore – or use as a base for exploring the Brecon Beacons."
            , wikipedia = "Llandovery"
            }

        -- Llanelli ->
        --     { name = "Llanelli"
        --     , blurb = Nothing "Llanelli"
        --     , wikipedia = "Llanelli"
        --     }
        -- NewcastleEmlyn ->
        --     { name = "Newcastle Emlyn"
        --     , blurb = Nothing "Newcastle_Emlyn"
        --     , wikipedia = "Newcastle_Emlyn"
        --     }
        -- StClears ->
        --     { name = "St Clears"
        --     , blurb = Nothing "St_Clears"
        --     , wikipedia = "St_Clears"
        --     }
        -- Whitland ->
        --     { name = "Whitland"
        --     , blurb = Nothing "Whitland"
        --     , wikipedia = "Whitland"
        --     }
        Aberaeron ->
            { name = "Aberaeron"
            , blurb = "A gorgeous harbour at the mouth of the River Aeron – named after the legendary Welsh God of War – Aberaeron’s tranquil streets and wooden promenade belie its fiery name. Its pier is often filled with fresh catches of lobster and crab."
            , wikipedia = "Aberaeron."
            }

        Aberystwyth ->
            { name = "Aberystwyth"
            , blurb = "If you fancy a night out on the West Coast, Aberystwyth is the town to hit. The Victorian promenade, built along a curving seafront, and the town’s pastel-shaded houses provide the perfect hangover cure the next day."
            , wikipedia = "Aberystwyth"
            }

        -- Cardigan ->
        --     { name = "Cardigan"
        --     , blurb = Nothing "Cardigan"
        --     , wikipedia = "Cardigan"
        --     }
        Lampeter ->
            { name = "Lampeter"
            , blurb = "Though a small town, Lampeter is a core exporter of Welsh coziness: it has the best collection of vintage quilts and blankets in the land. Tapestries have since given way to teaching, and Lampeter University is a hotbed of ecological research and activism."
            , wikipedia = "Lampeter"
            }

        Llandysul ->
            { name = "Llandysul"
            , blurb = "Beside Llandysul lies Pencoedfoel, one of Britain's biggest Iron Age hillforts, and the site of many rare archaeological finds. Once the heart of the Wales' wool industry, Llandsyul is now one of the country's finest fishing spots."
            , wikipedia = "Llandysul"
            }

        -- NewQuay ->
        --     { name = "New Quay"
        --     , blurb = Nothing "New_Quay"
        --     , wikipedia = "New_Quay"
        --     }
        -- Tregaron ->
        --     { name = "Tregaron"
        --     , blurb = Nothing "Tregaron"
        --     , wikipedia = "Tregaron"
        --     }
        -- Abergele ->
        --     { name = "Abergele"
        --     , blurb = Nothing "Abergele"
        --     , wikipedia = "Abergele"
        --     }
        -- ColwynBay ->
        --     { name = "Colwyn Bay"
        --     , blurb = Nothing "Colwyn_Bay"
        --     , wikipedia = "Colwyn_Bay"
        --     }
        -- Deganwy ->
        --     { name = "Deganwy"
        --     , blurb = Nothing "Deganwy"
        --     , wikipedia = "Deganwy"
        --     }
        Llandudno ->
            { name = "Llandudno"
            , blurb = "As Wales’ biggest seaside resort, Llandudno comes through with the country’s longest pier, award-winning beaches and Britain’s only cable-hauled trams. The beach lies between two beautiful limestone promontories: Great Orme and Little Orme."
            , wikipedia = "Llandudno"
            }

        -- LlandudnoJunction ->
        --     { name = "Llandudno Junction"
        --     , blurb = Nothing "Llandudno_Junction"
        --     , wikipedia = "Llandudno_Junction"
        --     }
        -- Llanfairfechan ->
        --     { name = "Llanfairfechan"
        --     , blurb = Nothing "Llanfairfechan"
        --     , wikipedia = "Llanfairfechan"
        --     }
        Llanrwst ->
            { name = "Llanrwst"
            , blurb = "Llanrwst is picturesque and perilous. Set on the edge of Snowdonia National Park, the road into town crosses a narrow stone bridge built in the 1600s – and brings you to a scenic town that runs entirely on renewable energy, from the wind farm set into the hills above."
            , wikipedia = "Llanrwst"
            }

        -- OldColwyn ->
        --     { name = "Old Colwyn"
        --     , blurb = Nothing "Old_Colwyn"
        --     , wikipedia = "Old_Colwyn"
        --     }
        -- Penmaenmawr ->
        --     { name = "Penmaenmawr"
        --     , blurb = Nothing "Penmaenmawr"
        --     , wikipedia = "Penmaenmawr"
        --     }
        -- Towyn ->
        --     { name = "Towyn"
        --     , blurb = Nothing "Towyn"
        --     , wikipedia = "Towyn"
        --     }
        -- Carrog ->
        --     { name = "Carrog"
        --     , blurb = Nothing "Carrog"
        --     , wikipedia = "Carrog"
        --     }
        -- Corwen ->
        --     { name = "Corwen"
        --     , blurb = Nothing "Corwen"
        --     , wikipedia = "Corwen"
        --     }
        Denbigh ->
            { name = "Denbigh"
            , blurb = "In medieval times, Denbigh was the centre of glove-making in Britain. It boasts 14th-century streets, a 15th-century friary, and the walls of an unfinished 16th-century cathedral – a project of the Earl of Leicester, the favourite of Queen Elizabeth I."
            , wikipedia = "Denbigh"
            }

        -- Gellifor ->
        --     { name = "Gellifor"
        --     , blurb = Nothing "Gellifor"
        --     , wikipedia = "Gellifor"
        --     }
        -- Llangollen ->
        --     { name = "Llangollen"
        --     , blurb = Nothing "Llangollen"
        --     , wikipedia = "Llangollen"
        --     }
        Prestatyn ->
            { name = "Prestatyn"
            , blurb = "Prestatyn is powered by the Welsh landscape. Its rambling routes and crystal waters were a hit with the Victorians – and now it's home to Britain's first major offshore wind farm, which powers Prestatyn and its nearby neighbours."
            , wikipedia = "Prestatyn"
            }

        -- Rhuddlan ->
        --     { name = "Rhuddlan"
        --     , blurb = Nothing "Rhuddlan"
        --     , wikipedia = "Rhuddlan"
        --     }
        Rhyl ->
            { name = "Rhyl"
            , blurb = "Rhyl grew during World War II, as Mancunians and Liverpudlians took to Wales to escape the bombs. But they stayed for its gorgeous coastline."
            , wikipedia = "Rhyl"
            }

        -- Ruthin ->
        --     { name = "Ruthin"
        --     , blurb = Nothing "Ruthin"
        --     , wikipedia = "Ruthin"
        --     }
        -- StAsaph ->
        --     { name = "St Asaph"
        --     , blurb = Nothing "St_Asaph"
        --     , wikipedia = "St_Asaph"
        --     }
        -- Bagallit ->
        --     { name = "Bagallit"
        --     , blurb = Nothing "Bagallit"
        --     , wikipedia = "Bagallit"
        --     }
        -- Broughton ->
        --     { name = "Broughton"
        --     , blurb = Nothing "Broughton"
        --     , wikipedia = "Broughton"
        --     }
        -- Buckley ->
        --     { name = "Buckley"
        --     , blurb = Nothing "Buckley"
        --     , wikipedia = "Buckley"
        --     }
        -- Caerwys ->
        --     { name = "Caerwys"
        --     , blurb = Nothing "Caerwys"
        --     , wikipedia = "Caerwys"
        --     }
        -- ConnahsQuay ->
        --     { name = "Connahs Quay"
        --     , blurb = Nothing "Connahs_Quay"
        --     , wikipedia = "Connahs_Quay"
        --     }
        -- Ewole ->
        --     { name = "Ewole"
        --     , blurb = Nothing "Ewole"
        --     , wikipedia = "Ewole"
        --     }
        -- Flint ->
        --     { name = "Flint"
        --     , blurb = Nothing "Flint"
        --     , wikipedia = "Flint"
        --     }
        -- Hawarden ->
        --     { name = "Hawarden"
        --     , blurb = Nothing "Hawarden"
        --     , wikipedia = "Hawarden"
        --     }
        -- Holywell ->
        --     { name = "Holywell"
        --     , blurb = Nothing "Holywell"
        --     , wikipedia = "Holywell"
        --     }
        -- Mold ->
        --     { name = "Mold"
        --     , blurb = Nothing "Mold"
        --     , wikipedia = "Mold"
        --     }
        -- Queensferry ->
        --     { name = "Queensferry"
        --     , blurb = Nothing "Queensferry"
        --     , wikipedia = "Queensferry"
        --     }
        -- Saltney ->
        --     { name = "Saltney"
        --     , blurb = Nothing "Saltney"
        --     , wikipedia = "Saltney"
        --     }
        -- Shotton ->
        --     { name = "Shotton"
        --     , blurb = Nothing "Shotton"
        --     , wikipedia = "Shotton"
        --     }
        -- Abertillery ->
        --     { name = "Abertillery"
        --     , blurb = Nothing "Abertillery"
        --     , wikipedia = "Abertillery"
        --     }
        -- Blaina ->
        --     { name = "Blaina"
        --     , blurb = Nothing "Blaina"
        --     , wikipedia = "Blaina"
        --     }
        -- Brynmawr ->
        --     { name = "Brynmawr"
        --     , blurb = Nothing "Brynmawr"
        --     , wikipedia = "Brynmawr"
        --     }
        -- Cwmbran ->
        --     { name = "Cwmbran"
        --     , blurb = Nothing "Cwmbran"
        --     , wikipedia = "Cwmbran"
        --     }
        -- EbbwVale ->
        --     { name = "Ebbw Vale"
        --     , blurb = Nothing "Ebbw_Vale"
        --     , wikipedia = "Ebbw_Vale"
        --     }
        -- Newport ->
        --     { name = "Newport"
        --     , blurb = Nothing "Newport,_Wales"
        --     , wikipedia = "Newport,_Wales"
        --     }
        -- Tafarnaubach ->
        --     { name = "Tafarnaubach"
        --     , blurb = Nothing "Tafarnaubach"
        --     , wikipedia = "Tafarnaubach"
        --     }
        -- Tredegar ->
        --     { name = "Tredegar"
        --     , blurb = Nothing "Tredegar"
        --     , wikipedia = "Tredegar"
        --     }
        Bala ->
            { name = "Bala"
            , blurb = "Bala is all about the lake: Llyn Tegid, Wales’ biggest. It’s filled with pike, perch, trout, salmon – and in the summer, jetskiers, kiteboarders and kayakers flock to Wales’ most popular watersports spot."
            , wikipedia = "Bala,_Gwynedd"
            }

        -- Bangor ->
        --     { name = "Bangor"
        --     , blurb = Nothing "Bangor"
        --     , wikipedia = "Bangor"
        --     }
        -- Barmouth ->
        --     { name = "Barmouth"
        --     , blurb = Nothing "Barmouth"
        --     , wikipedia = "Barmouth"
        --     }
        BetwsyCoed ->
            { name = "Betws y Coed"
            , blurb = "The gateway to Snowdonia, Betws-y-Coed is so picturesque it was built up as an artist’s colony in Victorian times. Painters and sculptors drawn in by its beauty two centuries ago are followed today by hikers and holidaymakers venturing into the National Park."
            , wikipedia = "Betws-y-Coed"
            }

        -- BlaenauFfestiniog ->
        --     { name = "Blaenau Ffestiniog"
        --     , blurb = "Blaenau_Ffestiniog"
        --     , wikipedia = "Blaenau_Ffestiniog"
        --     }
        Caernarfon ->
            { name = "Caernarfon"
            , blurb = "If Wales is the “castle capital of the world”, Caernarfon’s castle is the capital of capitals! Inspired by the walls of Constantinople, which King Edward I saw while on a crusade, the castle boasts two drawbridges and six portcullises: keeping enemies at bay and visitors amazed."
            , wikipedia = "Caernarfon"
            }

        -- Conwy ->
        --     { name = "Conwy"
        --     , blurb = Nothing "Conwy"
        --     , wikipedia = "Conwy"
        --     }
        -- Criccieth ->
        --     { name = "Criccieth"
        --     , blurb = Nothing "Criccieth"
        --     , wikipedia = "Criccieth"
        --     }
        -- Dolgellau ->
        --     { name = "Dolgellau"
        --     , blurb = Nothing "Dolgellau"
        --     , wikipedia = "Dolgellau"
        --     }
        -- Ffestiniog ->
        --     { name = "Ffestiniog"
        --     , blurb = Nothing "Ffestiniog"
        --     , wikipedia = "Ffestiniog"
        --     }
        -- Harlech ->
        --     { name = "Harlech"
        --     , blurb = Nothing "Harlech"
        --     , wikipedia = "Harlech"
        --     }
        -- Llanberis ->
        --     { name = "Llanberis"
        --     , blurb = Nothing "Llanberis"
        --     , wikipedia = "Llanberis"
        --     }
        -- Llanfachreth ->
        --     { name = "Llanfachreth"
        --     , blurb = Nothing "Llanfachreth"
        --     , wikipedia = "Llanfachreth"
        --     }
        Nefyn ->
            { name = "Nefyn"
            , blurb = "Nefyn counts its inhabitants by the hundreds, and its postcard-worthy beaches by the mile. Its Iron Age hillfort is a marvel of prehistoric engineering – its pub, the Ty Coch, is just as impressive, built on the sands of the beach."
            , wikipedia = "Nefyn"
            }

        -- Porthmadog ->
        --     { name = "Porthmadog"
        --     , blurb = Nothing "Porthmadog"
        --     , wikipedia = "Porthmadog"
        --     }
        Pwllheli ->
            { name = "Pwllheli"
            , blurb = "Its beaches are south-facing, its streets are interlacing: a lovely labyrinth of antique shops and ice cream sellers. Pwllheli is a great place to stay and a great place to start, as part of both the Llyn Coastal Path and the new Wales Coastal Path."
            , wikipedia = "Pwllheli"
            }

        Tywyn ->
            { name = "Tywyn"
            , blurb = "Tywyn holds the Cadfan stone, the earliest surviving example of Welsh written down (or carved out). It’s a seven-foot cross that has stood in the postcard town for over a thousand years."
            , wikipedia = "Tywyn"
            }

        -- YFelinheli ->
        --     { name = "Y Felinheli"
        --     , blurb = Nothing "Y_Felinheli"
        --     , wikipedia = "Y_Felinheli"
        --     }
        -- Aberdare ->
        --     { name = "Aberdare"
        --     , blurb = Nothing "Aberdare"
        --     , wikipedia = "Aberdare"
        --     }
        -- Bridgend ->
        --     { name = "Bridgend"
        --     , blurb = Nothing "Bridgend"
        --     , wikipedia = "Bridgend"
        --     }
        -- Caerphilly ->
        --     { name = "Caerphilly"
        --     , blurb = Nothing "Caerphilly"
        --     , wikipedia = "Caerphilly"
        --     }
        -- Llantrisant ->
        --     { name = "Llantrisant"
        --     , blurb = Nothing "Llantrisant"
        --     , wikipedia = "Llantrisant"
        --     }
        -- Maesteg ->
        --     { name = "Maesteg"
        --     , blurb = Nothing "Maesteg"
        --     , wikipedia = "Maesteg"
        --     }
        MerthyrTydfil ->
            { name = "Merthyr Tydfil"
            , blurb = "Rich in natural resources and history, Merthyr Tydfil is a picture of Wales in miniature. Two centuries ago, it was home to the largest ironworks in the world, political radicalism and riots. Today, regeneration has brought a new bike park to go alongside its castle and historical mountain railway."
            , wikipedia = "Merthyr_Tydfil"
            }

        -- Pontypridd ->
        --     { name = "Pontypridd"
        --     , blurb = Nothing "Pontypridd"
        --     , wikipedia = "Pontypridd"
        --     }
        -- Porth ->
        --     { name = "Porth"
        --     , blurb = Nothing "Porth"
        --     , wikipedia = "Porth"
        --     }
        -- Porthcawl ->
        --     { name = "Porthcawl"
        --     , blurb = Nothing "Porthcawl"
        --     , wikipedia = "Porthcawl"
        --     }
        Abergavenny ->
            { name = "Abergavenny"
            , blurb = "Abergavenny is filled with food, glorious food. It’s the culinary capital of the Usk Valley and holds a cattle market every week in town – as it has done since 1863."
            , wikipedia = "Abergavenny"
            }

        -- Caldicot ->
        --     { name = "Caldicot"
        --     , blurb = Nothing "Caldicot"
        --     , wikipedia = "Caldicot"
        --     }
        -- Chepstow ->
        --     { name = "Chepstow"
        --     , blurb = Nothing "Chepstow"
        --     , wikipedia = "Chepstow"
        --     }
        -- Monmouth ->
        --     { name = "Monmouth"
        --     , blurb = Nothing "Monmouth"
        --     , wikipedia = "Monmouth"
        --     }
        -- Usk ->
        --     { name = "Usk"
        --     , blurb = Nothing "Usk"
        --     , wikipedia = "Usk"
        --     }
        -- Fishguard ->
        --     { name = "Fishguard"
        --     , blurb = Nothing "Fishguard"
        --     , wikipedia = "Fishguard"
        --     }
        -- Goodwick ->
        --     { name = "Goodwick"
        --     , blurb = Nothing "Goodwick"
        --     , wikipedia = "Goodwick"
        --     }
        -- Hakin ->
        --     { name = "Hakin"
        --     , blurb = Nothing "Hakin"
        --     , wikipedia = "Hakin"
        --     }
        -- Haverfordwest ->
        --     { name = "Haverfordwest"
        --     , blurb = Nothing "Haverfordwest"
        --     , wikipedia = "Haverfordwest"
        --     }
        -- MilfordHaven ->
        --     { name = "Milford Haven"
        --     , blurb = Nothing "Milford_Haven"
        --     , wikipedia = "Milford_Haven"
        --     }
        -- Narberth ->
        --     { name = "Narberth"
        --     , blurb = Nothing "Narberth"
        --     , wikipedia = "Narberth"
        --     }
        -- Neyland ->
        --     { name = "Neyland"
        --     , blurb = Nothing "Neyland"
        --     , wikipedia = "Neyland"
        --     }
        -- Pembroke ->
        --     { name = "Pembroke"
        --     , blurb = Nothing "Pembroke"
        --     , wikipedia = "Pembroke"
        --     }
        -- PembrokeDock ->
        --     { name = "Pembroke Dock"
        --     , blurb = Nothing "Pembroke_Dock"
        --     , wikipedia = "Pembroke_Dock"
        --     }
        -- StDavids ->
        --     { name = "St Davids"
        --     , blurb = Nothing "St_Davids"
        --     , wikipedia = "St_Davids"
        --     }
        -- Tenby ->
        --     { name = "Tenby"
        --     , blurb = Nothing "Tenby"
        --     , wikipedia = "Tenby"
        --     }
        -- Brecon ->
        --     { name = "Brecon"
        --     , blurb = Nothing "Brecon"
        --     , wikipedia = "Brecon"
        --     }
        -- BuilthWells ->
        --     { name = "Builth Wells"
        --     , blurb = Nothing "Builth_Wells"
        --     , wikipedia = "Builth_Wells"
        --     }
        -- Cefnllys ->
        --     { name = "Cefnllys"
        --     , blurb = Nothing "Cefnllys"
        --     , wikipedia = "Cefnllys"
        --     }
        -- Crickhowell ->
        --     { name = "Crickhowell"
        --     , blurb = Nothing "Crickhowell"
        --     , wikipedia = "Crickhowell"
        --     }
        -- HayOnWye ->
        --     { name = "Hay on Wye"
        --     , blurb = Nothing "Hay-on-Wye"
        --     , wikipedia = "Hay-on-Wye"
        --     }
        -- Knighton ->
        --     { name = "Knighton"
        --     , blurb = Nothing "Knighton"
        --     , wikipedia = "Knighton"
        --     }
        -- LlandrindodWells ->
        --     { name = "Llandrindod Wells"
        --     , blurb = Nothing "Llandrindod_Wells"
        --     , wikipedia = "Llandrindod_Wells"
        --     }
        -- LlanfairCaereinion ->
        --     { name = "Llanfair Caereinion"
        --     , blurb = Nothing "Llanfair_Caereinion"
        --     , wikipedia = "Llanfair_Caereinion"
        --     }
        -- Llanfyllin ->
        --     { name = "Llanfyllin"
        --     , blurb = Nothing "Llanfyllin"
        --     , wikipedia = "Llanfyllin"
        --     }
        -- Llangors ->
        --     { name = "Llangors"
        --     , blurb = Nothing "Llangors"
        --     , wikipedia = "Llangors"
        --     }
        -- Llanidloes ->
        --     { name = "Llanidloes"
        --     , blurb = Nothing "Llanidloes"
        --     , wikipedia = "Llanidloes"
        --     }
        -- LlanwrtydWells ->
        --     { name = "Llanwrtyd Wells"
        --     , blurb = Nothing "Llanwrtyd_Wells"
        --     , wikipedia = "Llanwrtyd_Wells"
        --     }
        -- Machynlleth ->
        --     { name = "Machynlleth"
        --     , blurb = Nothing "Machynlleth"
        --     , wikipedia = "Machynlleth"
        --     }
        -- Montgomery ->
        --     { name = "Montgomery"
        --     , blurb = Nothing "Montgomery"
        --     , wikipedia = "Montgomery"
        --     }
        -- Newtown ->
        --     { name = "Newtown"
        --     , blurb = Nothing "Newtown"
        --     , wikipedia = "Newtown"
        --     }
        -- OldRadnor ->
        --     { name = "Old Radnor"
        --     , blurb = Nothing "Old_Radnor"
        --     , wikipedia = "Old_Radnor"
        --     }
        -- Presteigne ->
        --     { name = "Presteigne"
        --     , blurb = Nothing "Presteigne"
        --     , wikipedia = "Presteigne"
        --     }
        -- Rhayader ->
        --     { name = "Rhayader"
        --     , blurb = Nothing "Rhayader"
        --     , wikipedia = "Rhayader"
        --     }
        -- Talgarth ->
        --     { name = "Talgarth"
        --     , blurb = Nothing "Talgarth"
        --     , wikipedia = "Talgarth"
        --     }
        -- Welshpool ->
        --     { name = "Welshpool"
        --     , blurb = Nothing "Welshpool"
        --     , wikipedia = "Welshpool"
        --     }
        -- Barry ->
        --     { name = "Barry"
        --     , blurb = Nothing "Barry"
        --     , wikipedia = "Barry"
        --     }
        Cardiff ->
            { name = "Cardiff"
            , blurb = "Wales' eminently spellable capital city."
            , wikipedia = "Cardiff"
            }

        -- Cowbridge ->
        --     { name = "Cowbridge"
        --     , blurb = Nothing "Cowbridge"
        --     , wikipedia = "Cowbridge"
        --     }
        -- LlantwitMajor ->
        --     { name = "Llantwit Major"
        --     , blurb = Nothing "Llantwit_Major"
        --     , wikipedia = "Llantwit_Major"
        --     }
        -- Penarth ->
        --     { name = "Penarth"
        --     , blurb = Nothing "Penarth"
        --     , wikipedia = "Penarth"
        --     }
        -- Gorseinon ->
        --     { name = "Gorseinon"
        --     , blurb = Nothing "Gorseinon"
        --     , wikipedia = "Gorseinon"
        --     }
        -- LliwValey ->
        --     { name = "Lliw Valey"
        --     , blurb = Nothing "Lliw_Valey"
        --     , wikipedia = "Lliw_Valey"
        --     }
        -- Neath ->
        --     { name = "Neath"
        --     , blurb = Nothing "Neath"
        --     , wikipedia = "Neath"
        --     }
        -- PortTalbot ->
        --     { name = "Port Talbot"
        --     , blurb = Nothing "Port_Talbot"
        --     , wikipedia = "Port_Talbot"
        --     }
        -- Swansea ->
        --     { name = "Swansea"
        --     , blurb = Nothing "Swansea"
        --     , wikipedia = "Swansea"
        --     }
        -- Chirk ->
        --     { name = "Chirk"
        --     , blurb = Nothing "Chirk"
        --     , wikipedia = "Chirk"
        --     }
        -- OvertonOnDee ->
        --     { name = "Overton on Dee"
        --     , blurb = Nothing "Overton-on-Dee"
        --     , wikipedia = "Overton-on-Dee"
        --     }
        -- Rhosllannerchrugog ->
        --     { name = "Rhosllannerchrugog"
        --     , blurb = Nothing "Rhosllannerchrugog"
        --     , wikipedia = "Rhosllannerchrugog"
        --     }
        -- Rhosnesni ->
        --     { name = "Rhosnesni"
        --     , blurb = Nothing "Rhosnesni"
        --     , wikipedia = "Rhosnesni"
        --     }
        -- Wrexham ->
        --     { name = "Wrexham"
        --     , blurb = Nothing "Wrexham"
        --     , wikipedia = "Wrexham"
        --     }
        Manorbier ->
            { name = "Manorbier"
            , blurb = "Deep, deep history is in Manorbier. The stream that runs through the grassy village has fossils in the riverbed, and pieces of flint, sharpened tens of millennia ago, are common in the hills and beaches nearby."
            , wikipedia = "Manorbier"
            }

        PistyllRhaeadr ->
            { name = "Pistyll Rhaeadr"
            , blurb = "Wales’ highest waterfall is a beautiful ribbon of water which drops 230 feet into a mossy rock basin – shaped by nature in a secluded valley, in the shadows of the Berwyn Mountains."
            , wikipedia = "Pistyll_Rhaeadr"
            }

        Portmeirion ->
            { name = "Portmeirion"
            , blurb = "Portmeirion is Welsh Disneyland: a magical, uninhabited seaside utopia. The entire village is built with material taken from abandoned stately homes. To visit is to wander through a walking dream of towers, domes, courtyards and arches. "
            , wikipedia = "Portmeirion"
            }

        Rhossili ->
            { name = "Rhossili"
            , blurb = "Rhossili looks lovely on foot, and lovely when you’ve taken flight: it’s one of Wales’ best hang-gliding destinations. And its beach changes hour by hour – the high tide makes new islands daily from the rocky outcrops out at sea."
            , wikipedia = "Rhossili"
            }

        YsbytyCynfyn ->
            { name = "Ysbyty Cynfyn"
            , blurb = "The graveyard at Ysbyty Cynfyn is full of stories: the merging of beliefs, unruly games and a medical marvel. The remains of a pagan stone circle lie within the churchyard walls – where fairs and cockfights were once held, and the world’s first recorded quadruplets are buried."
            , wikipedia = "Ysbyty_Cynfyn"
            }
