module Content.WelshPlaces exposing (Info, Place(..), getInfo, infoLookup)

import Lib.Trie as Trie


type
    Place
    -- Amlwch
    -- | Beaumaris
    -- | Benllech
    -- | Holyhead
    -- | Llanfairpwllgwyngyll
    -- | Llangefni
    -- | MenaiBridge
    -- | Ammanford
    -- | BurryPort
    -- | Carmarthen
    -- | Garnant
    -- | Glanamman
    -- | Kidwelly
    -- | Laugharne
    -- | Llandeilo
    = Llandovery
      -- | Llanelli
      -- | NewcastleEmlyn
      -- | StClears
      -- | Whitland
    | Aberaeron
    | Aberystwyth
      -- | Cardigan
      -- | Lampeter
      -- | Llandysul
      -- | NewQuay
      -- | Tregaron
      -- | Abergele
      -- | ColwynBay
      -- | Conwy
      -- | Deganwy
    | Llandudno
      -- | LlandudnoJunction
      -- | Llanfairfechan
      -- | Llanrwst
      -- | OldColwyn
      -- | Penmaenmawr
      -- | Towyn
      -- | Carrog
      -- | Corwen
      -- | Denbigh
      -- | Gellifor
      -- | Llangollen
      -- | Prestatyn
      -- | Rhuddlan
    | Rhyl
      -- | Ruthin
      -- | StAsaph
      -- | Bagallit
      -- | Broughton
      -- | Buckley
      -- | Caerwys
      -- | ConnahsQuay
      -- | Ewole
      -- | Flint
      -- | Hawarden
      -- | Holywell
      -- | Mold
      -- | Queensferry
      -- | Saltney
      -- | Shotton
      -- | Abertillery
      -- | Blaina
      -- | Brynmawr
      -- | Cwmbran
      -- | EbbwVale
      -- | Tafarnaubach
      -- | Tredegar
    | Bala
      -- | Bangor
      -- | Barmouth
    | BetwsyCoed
      -- | BlaenauFfestiniog
    | Caernarfon
      -- | Criccieth
      -- | Dolgellau
      -- | Ffestiniog
      -- | Harlech
      -- | Llanberis
      -- | Llanfachreth
      -- | Nefyn
      -- | Porthmadog
    | Pwllheli
    | Tywyn
      -- | YFelinheli
      -- | Aberdare
      -- | Bridgend
      -- | Caerphilly
      -- | Llantrisant
      -- | Maesteg
    | MerthyrTydfil
      -- | Pontypridd
      -- | Porth
      -- | Porthcawl
    | Abergavenny
      -- | Caldicot
      -- | Chepstow
      -- | Monmouth
      -- | Usk
      -- | Fishguard
      -- | Goodwick
      -- | Hakin
      -- | Haverfordwest
      -- | MilfordHaven
      -- | Narberth
      -- | Newport
      -- | Neyland
      -- | Pembroke
      -- | PembrokeDock
      -- | StDavids
      -- | Tenby
      -- | Brecon
      -- | BuilthWells
      -- | Cefnllys
      -- | Crickhowell
      -- | HayOnWye
      -- | Knighton
      -- | LlandrindodWells
      -- | LlanfairCaereinion
      -- | Llanfyllin
      -- | Llangors
      -- | Llanidloes
      -- | LlanwrtydWells
      -- | Machynlleth
      -- | Montgomery
      -- | Newtown
      -- | OldRadnor
      -- | Presteigne
      -- | Rhayader
      -- | Talgarth
      -- | Welshpool
      -- | Barry
    | Cardiff
      -- | Cowbridge
      -- | LlantwitMajor
      -- | Penarth
      -- | Gorseinon
      -- | LliwValey
      -- | Neath
      -- | PortTalbot
      -- | Swansea
      -- | Chirk
      -- | OvertonOnDee
      -- | Rhosllannerchrugog
      -- | Rhosnesni
      -- | Wrexham
    | Manorbier
    | PistyllRhaeadr
    | Portmeirion
    | Rhossili
    | YsbytyCynfyn


type alias Info =
    { name : String
    , blurb : String
    , wikipedia : String
    }


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
        -- Llanfairpwllgwyngyll ->
        --     { name = "Llanfairpwllgwyngyll"
        --     , blurb = Nothing "Llanfairpwllgwyngyll"
        --     , wikipedia = "Llanfairpwllgwyngyll"
        --     }
        -- Llangefni ->
        --     { name = "Llangefni"
        --     , blurb = Nothing "Llangefni"
        --     , wikipedia = "Llangefni"
        --     }
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
        -- Kidwelly ->
        --     { name = "Kidwelly"
        --     , blurb = Nothing "Kidwelly"
        --     , wikipedia = "Kidwelly"
        --     }
        -- Laugharne ->
        --     { name = "Laugharne"
        --     , blurb = Nothing "Laugharne"
        --     , wikipedia = "Laugharne"
        --     }
        -- Llandeilo ->
        --     { name = "Llandeilo"
        --     , blurb = Nothing "Llandeilo"
        --     , wikipedia = "Llandeilo"
        --     }
        Llandovery ->
            { name = "Llandovery"
            , blurb = "Lovely Llandovery has a lovely name: it means ‘the church among the waters’. A scenic town to explore – or ues as a base for exploring the Brecon Beacons."
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
            , blurb = "If you’re fancy a night out on the West Coast, Aberystwyth is the town to hit. The Victorian promenade built along a curving seafront and the town’s pastel-shaded houses provide the perfect hangover cure the next day."
            , wikipedia = "Aberystwyth"
            }

        -- Cardigan ->
        --     { name = "Cardigan"
        --     , blurb = Nothing "Cardigan"
        --     , wikipedia = "Cardigan"
        --     }
        -- Lampeter ->
        --     { name = "Lampeter"
        --     , blurb = Nothing "Lampeter"
        --     , wikipedia = "Lampeter"
        --     }
        -- Llandysul ->
        --     { name = "Llandysul"
        --     , blurb = Nothing "Llandysul"
        --     , wikipedia = "Llandysul"
        --     }
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
            , blurb = "As Wales’ biggest seaside resort, Llandudno comes through with the country’s longest pier, award winning-beaches and Britain’s only cable-hauled trams. The beach lies between two beautiful, and cutely named, limestone promontories: Great Orme and Little Orme."
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
        -- Llanrwst ->
        --     { name = "Llanrwst"
        --     , blurb = Nothing "Llanrwst"
        --     , wikipedia = "Llanrwst"
        --     }
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
        -- Denbigh ->
        --     { name = "Denbigh"
        --     , blurb = Nothing "Denbigh"
        --     , wikipedia = "Denbigh"
        --     }
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
        -- Prestatyn ->
        --     { name = "Prestatyn"
        --     , blurb = Nothing "Prestatyn"
        --     , wikipedia = "Prestatyn"
        --     }
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
            , blurb = "Bala is all about the lake: Llyn Tegid, Wales’ biggest. It’s filled with pike, perch, trout, salmon and, in the summer, jetskiers, kiteboarders and kayakers flock to Wales’ most popular watersports spot"
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
            , blurb = "If Wales is the “castle capital of the world”, Caernarfon’s castle might just Wales’ capital  the castle capital of Wales. Inspired by the walls of Constantinople King Edward I saw while on a crusade, the castle boasts two drawbridges and six portcullises: keeping enemies away and visitors amazed."
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
        -- Nefyn ->
        --     { name = "Nefyn"
        --     , blurb = Nothing "Nefyn"
        --     , wikipedia = "Nefyn"
        --     }
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
            , blurb = "The home of historical Welsh, Tywyn holds the Cadfan stone, the earliest surviving example of Welsh written down (or carved out). It’s a seven-foot cross that has stood in the postcard town for centuries – a dozen of them."
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
            , blurb = "Rich in natural resources and history, Merthyr Tydfil is a picture of Wales in miniature. Two centuries ago, it was home to the largest ironworks in the world, political radicalism and riots. Today, regeneration has given it a new bike park to go alongside its castle and historical mountain railway."
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
            , blurb = "Abergavenny is filled with food, glorious food. It’s the culinary capital of the Usk Valley and holds cattle market every week in town – as it has done since 1863."
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
            , blurb = "The captial city of Wales, located in the south west of the country."
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
            , blurb = "Deep, deep history is in Manorbier. The stream which runs through the grassy village has fossils on its bed, and pieces of flint, sharpened tens of millennia ago, are common in the hills and on the beaches nearby."
            , wikipedia = "Manorbier"
            }

        PistyllRhaeadr ->
            { name = "Pistyll Rhaeadr"
            , blurb = "Wales’ highest waterfall is a beautiful ribbon of water which drops 230 feet into a mossy rock basin – built by nature in a secluded valley in the shadows of the Berwyn Mountains."
            , wikipedia = "Pistyll_Rhaeadr"
            }

        Portmeirion ->
            { name = "Portmeirion"
            , blurb = "Portmeirion is Welsh Disneyland: a magical, uninhabited seaside utopia. The entire village is built from material from abandoned stately homes and looks like a vision of towers and domes, courtyards and arches. "
            , wikipedia = "Portmeirion"
            }

        Rhossili ->
            { name = "Rhossili"
            , blurb = "Rhossili looks lovely on foot, and lovely when you’re taken flight: it’s one of Wales’ best hang-gliding destinations. And its beach changes hour by hour – the high tide makes new islands daily from the rocky outcrops out at sea."
            , wikipedia = "Rhossili"
            }

        YsbytyCynfyn ->
            { name = "Ysbyty Cynfyn"
            , blurb = "The graveyard at Ysbyty Cynfyn is full of stories: the merging of beliefs, unruly games and a medical marvel. The remains of a pagan stone circle lie within the churchyard walls – where fairs and cockfights were once held, and the world’s first recorded quadruplet babies were born."
            , wikipedia = "Ysbyty_Cynfyn"
            }


infoLookup : Trie.Trie Place
infoLookup =
    let
        empty =
            Trie.empty

        insert =
            Trie.insert
    in
    empty
        -- |> insert "amlwch" Amlwch
        -- |> insert "beaumaris" Beaumaris
        -- |> insert "benllech" Benllech
        -- |> insert "holyhead" Holyhead
        -- |> insert "llanfairpwllgwyngyll" Llanfairpwllgwyngyll
        -- |> insert "llangefni" Llangefni
        -- |> insert "menaibridge" MenaiBridge
        -- |> insert "ammanford" Ammanford
        -- |> insert "burryport" BurryPort
        -- |> insert "carmarthen" Carmarthen
        -- |> insert "garnant" Garnant
        -- |> insert "glanamman" Glanamman
        -- |> insert "kidwelly" Kidwelly
        -- |> insert "laugharne" Laugharne
        -- |> insert "llandeilo" Llandeilo
        |> insert "llandovery" Llandovery
        -- |> insert "llanelli" Llanelli
        -- |> insert "newcastleemlyn" NewcastleEmlyn
        -- |> insert "stclears" StClears
        -- |> insert "whitland" Whitland
        |> insert "aberaeron" Aberaeron
        |> insert "aberystwyth" Aberystwyth
        -- |> insert "cardigan" Cardigan
        -- |> insert "lampeter" Lampeter
        -- |> insert "llandysul" Llandysul
        -- |> insert "newquay" NewQuay
        -- |> insert "tregaron" Tregaron
        -- |> insert "abergele" Abergele
        -- |> insert "colwynbay" ColwynBay
        -- |> insert "conwy" Conwy
        -- |> insert "deganwy" Deganwy
        |> insert "llandudno" Llandudno
        -- |> insert "llandudnojunction" LlandudnoJunction
        -- |> insert "llanfairfechan" Llanfairfechan
        -- |> insert "llanrwst" Llanrwst
        -- |> insert "oldcolwyn" OldColwyn
        -- |> insert "penmaenmawr" Penmaenmawr
        -- |> insert "towyn" Towyn
        -- |> insert "carrog" Carrog
        -- |> insert "corwen" Corwen
        -- |> insert "denbigh" Denbigh
        -- |> insert "gellifor" Gellifor
        -- |> insert "llangollen" Llangollen
        -- |> insert "prestatyn" Prestatyn
        -- |> insert "rhuddlan" Rhuddlan
        |> insert "rhyl" Rhyl
        -- |> insert "ruthin" Ruthin
        -- |> insert "stasaph" StAsaph
        -- |> insert "bagallit" Bagallit
        -- |> insert "broughton" Broughton
        -- |> insert "buckley" Buckley
        -- |> insert "caerwys" Caerwys
        -- |> insert "connahsquay" ConnahsQuay
        -- |> insert "ewole" Ewole
        -- |> insert "flint" Flint
        -- |> insert "hawarden" Hawarden
        -- |> insert "holywell" Holywell
        -- |> insert "mold" Mold
        -- |> insert "queensferry" Queensferry
        -- |> insert "saltney" Saltney
        -- |> insert "shotton" Shotton
        -- |> insert "abertillery" Abertillery
        -- |> insert "blaina" Blaina
        -- |> insert "brynmawr" Brynmawr
        -- |> insert "cwmbran" Cwmbran
        -- |> insert "ebbwvale" EbbwVale
        -- |> insert "tafarnaubach" Tafarnaubach
        -- |> insert "tredegar" Tredegar
        |> insert "bala" Bala
        -- |> insert "bangor" Bangor
        -- |> insert "barmouth" Barmouth
        |> insert "betwsycoed" BetwsyCoed
        -- |> insert "blaenauffestiniog" BlaenauFfestiniog
        |> insert "caernarfon" Caernarfon
        -- |> insert "criccieth" Criccieth
        -- |> insert "dolgellau" Dolgellau
        -- |> insert "ffestiniog" Ffestiniog
        -- |> insert "harlech" Harlech
        -- |> insert "llanberis" Llanberis
        -- |> insert "llanfachreth" Llanfachreth
        -- |> insert "nefyn" Nefyn
        -- |> insert "porthmadog" Porthmadog
        |> insert "pwllheli" Pwllheli
        |> insert "tywyn" Tywyn
        -- |> insert "yfelinheli" YFelinheli
        -- |> insert "aberdare" Aberdare
        -- |> insert "bridgend" Bridgend
        -- |> insert "caerphilly" Caerphilly
        -- |> insert "llantrisant" Llantrisant
        -- |> insert "maesteg" Maesteg
        |> insert "merthyrtydfil" MerthyrTydfil
        -- |> insert "pontypridd" Pontypridd
        -- |> insert "porth" Porth
        -- |> insert "porthcawl" Porthcawl
        |> insert "abergavenny" Abergavenny
        -- |> insert "caldicot" Caldicot
        -- |> insert "chepstow" Chepstow
        -- |> insert "monmouth" Monmouth
        -- |> insert "usk" Usk
        -- |> insert "fishguard" Fishguard
        -- |> insert "goodwick" Goodwick
        -- |> insert "hakin" Hakin
        -- |> insert "haverfordwest" Haverfordwest
        -- |> insert "milfordhaven" MilfordHaven
        -- |> insert "narberth" Narberth
        -- |> insert "newport" Newport
        -- |> insert "neyland" Neyland
        -- |> insert "pembroke" Pembroke
        -- |> insert "pembrokedock" PembrokeDock
        -- |> insert "stdavids" StDavids
        -- |> insert "tenby" Tenby
        -- |> insert "brecon" Brecon
        -- |> insert "builthwells" BuilthWells
        -- |> insert "cefnllys" Cefnllys
        -- |> insert "crickhowell" Crickhowell
        -- |> insert "hayonwye" HayOnWye
        -- |> insert "knighton" Knighton
        -- |> insert "llandrindodwells" LlandrindodWells
        -- |> insert "llanfaircaereinion" LlanfairCaereinion
        -- |> insert "llanfyllin" Llanfyllin
        -- |> insert "llangors" Llangors
        -- |> insert "llanidloes" Llanidloes
        -- |> insert "llanwrtydwells" LlanwrtydWells
        -- |> insert "machynlleth" Machynlleth
        -- |> insert "montgomery" Montgomery
        -- |> insert "newtown" Newtown
        -- |> insert "oldradnor" OldRadnor
        -- |> insert "presteigne" Presteigne
        -- |> insert "rhayader" Rhayader
        -- |> insert "talgarth" Talgarth
        -- |> insert "welshpool" Welshpool
        -- |> insert "barry" Barry
        |> insert "cardiff" Cardiff
        -- |> insert "cowbridge" Cowbridge
        -- |> insert "llantwitmajor" LlantwitMajor
        -- |> insert "penarth" Penarth
        -- |> insert "gorseinon" Gorseinon
        -- |> insert "lliwvaley" LliwValey
        -- |> insert "neath" Neath
        -- |> insert "porttalbot" PortTalbot
        -- |> insert "swansea" Swansea
        -- |> insert "chirk" Chirk
        -- |> insert "overtonondee" OvertonOnDee
        -- |> insert "rhosllannerchrugog" Rhosllannerchrugog
        -- |> insert "rhosnesni" Rhosnesni
        -- |> insert "wrexham" Wrexham
        |> insert "manorbier" Manorbier
        |> insert "pistyllrhaeadr" PistyllRhaeadr
        |> insert "portmeirion" Portmeirion
        |> insert "rhossili" Rhossili
        |> insert "ysbytycynfyn" YsbytyCynfyn
