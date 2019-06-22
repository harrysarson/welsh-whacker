module Content.WelshPlaces exposing (Info, Place(..), getInfo, infoLookup)

import Dict exposing (Dict)
import Lib.Trie as Trie


type Place
    = Amlwch
    | Beaumaris
    | Benllech
    | Holyhead
    | Llanfairpwllgwyngyll
    | Llangefni
    | MenaiBridge
    | Ammanford
    | BurryPort
    | Carmarthen
    | Garnant
    | Glanamman
    | Kidwelly
    | Laugharne
    | Llandeilo
    | Llandovery
    | Llanelli
    | NewcastleEmlyn
    | StClears
    | Whitland
    | Aberaeron
    | Aberystwyth
    | Cardigan
    | Lampeter
    | Llandysul
    | NewQuay
    | Tregaron
    | Abergele
    | ColwynBay
    | Conwy
    | Deganwy
    | Llandudno
    | LlandudnoJunction
    | Llanfairfechan
    | Llanrwst
    | OldColwyn
    | Penmaenmawr
    | Towyn
    | Carrog
    | Corwen
    | Denbigh
    | Gellifor
    | Llangollen
    | Prestatyn
    | Rhuddlan
    | Rhyl
    | Ruthin
    | StAsaph
    | Bagallit
    | Broughton
    | Buckley
    | Caerwys
    | ConnahsQuay
    | Ewole
    | Flint
    | Hawarden
    | Holywell
    | Mold
    | Queensferry
    | Saltney
    | Shotton
    | Abertillery
    | Blaina
    | Brynmawr
    | Cwmbran
    | EbbwVale
    | Tafarnaubach
    | Tredegar
    | Bala
    | Bangor
    | Barmouth
    | BetwsyCoed
    | BlaenauFfestiniog
    | Caernarfon
    | Criccieth
    | Dolgellau
    | Ffestiniog
    | Harlech
    | Llanberis
    | Llanfachreth
    | Nefyn
    | Porthmadog
    | Pwllheli
    | Tywyn
    | YFelinheli
    | Aberdare
    | Bridgend
    | Caerphilly
    | Llantrisant
    | Maesteg
    | MerthyrTydfil
    | Pontypridd
    | Porth
    | Porthcawl
    | Abergavenny
    | Caldicot
    | Chepstow
    | Monmouth
    | Usk
    | Fishguard
    | Goodwick
    | Hakin
    | Haverfordwest
    | MilfordHaven
    | Narberth
    | Newport
    | Neyland
    | Pembroke
    | PembrokeDock
    | StDavids
    | Tenby
    | Brecon
    | BuilthWells
    | Cefnllys
    | Crickhowell
    | HayOnWye
    | Knighton
    | LlandrindodWells
    | LlanfairCaereinion
    | Llanfyllin
    | Llangors
    | Llanidloes
    | LlanwrtydWells
    | Machynlleth
    | Montgomery
    | Newtown
    | OldRadnor
    | Presteigne
    | Rhayader
    | Talgarth
    | Welshpool
    | Barry
    | Cardiff
    | Cowbridge
    | LlantwitMajor
    | Penarth
    | Gorseinon
    | LliwValey
    | Neath
    | PortTalbot
    | Swansea
    | Chirk
    | OvertonOnDee
    | Rhosllannerchrugog
    | Rhosnesni
    | Wrexham


type alias Info =
    { name : String
    , wikipedia : String
    }


getInfo : Place -> Info
getInfo place =
    case place of
        Amlwch ->
            { name = "Amlwch"
            , wikipedia = "Amlwch"
            }

        Beaumaris ->
            { name = "Beaumaris"
            , wikipedia = "Beaumaris"
            }

        Benllech ->
            { name = "Benllech"
            , wikipedia = "Benllech"
            }

        Holyhead ->
            { name = "Holyhead"
            , wikipedia = "Holyhead"
            }

        Llanfairpwllgwyngyll ->
            { name = "Llanfairpwllgwyngyll"
            , wikipedia = "Llanfairpwllgwyngyll"
            }

        Llangefni ->
            { name = "Llangefni"
            , wikipedia = "Llangefni"
            }

        MenaiBridge ->
            { name = "Menai Bridge"
            , wikipedia = "Menai_Bridge"
            }

        Ammanford ->
            { name = "Ammanford"
            , wikipedia = "Ammanford"
            }

        BurryPort ->
            { name = "Burry Port"
            , wikipedia = "Burry_Port"
            }

        Carmarthen ->
            { name = "Carmarthen"
            , wikipedia = "Carmarthen"
            }

        Garnant ->
            { name = "Garnant"
            , wikipedia = "Garnant"
            }

        Glanamman ->
            { name = "Glanamman"
            , wikipedia = "Glanamman"
            }

        Kidwelly ->
            { name = "Kidwelly"
            , wikipedia = "Kidwelly"
            }

        Laugharne ->
            { name = "Laugharne"
            , wikipedia = "Laugharne"
            }

        Llandeilo ->
            { name = "Llandeilo"
            , wikipedia = "Llandeilo"
            }

        Llandovery ->
            { name = "Llandovery"
            , wikipedia = "Llandovery"
            }

        Llanelli ->
            { name = "Llanelli"
            , wikipedia = "Llanelli"
            }

        NewcastleEmlyn ->
            { name = "Newcastle Emlyn"
            , wikipedia = "Newcastle_Emlyn"
            }

        StClears ->
            { name = "St Clears"
            , wikipedia = "St_Clears"
            }

        Whitland ->
            { name = "Whitland"
            , wikipedia = "Whitland"
            }

        Aberaeron ->
            { name = "Aberaeron"
            , wikipedia = "Aberaeron"
            }

        Aberystwyth ->
            { name = "Aberystwyth"
            , wikipedia = "Aberystwyth"
            }

        Cardigan ->
            { name = "Cardigan"
            , wikipedia = "Cardigan"
            }

        Lampeter ->
            { name = "Lampeter"
            , wikipedia = "Lampeter"
            }

        Llandysul ->
            { name = "Llandysul"
            , wikipedia = "Llandysul"
            }

        NewQuay ->
            { name = "New Quay"
            , wikipedia = "New_Quay"
            }

        Tregaron ->
            { name = "Tregaron"
            , wikipedia = "Tregaron"
            }

        Abergele ->
            { name = "Abergele"
            , wikipedia = "Abergele"
            }

        ColwynBay ->
            { name = "Colwyn Bay"
            , wikipedia = "Colwyn_Bay"
            }

        Deganwy ->
            { name = "Deganwy"
            , wikipedia = "Deganwy"
            }

        Llandudno ->
            { name = "Llandudno"
            , wikipedia = "Llandudno"
            }

        LlandudnoJunction ->
            { name = "Llandudno Junction"
            , wikipedia = "Llandudno_Junction"
            }

        Llanfairfechan ->
            { name = "Llanfairfechan"
            , wikipedia = "Llanfairfechan"
            }

        Llanrwst ->
            { name = "Llanrwst"
            , wikipedia = "Llanrwst"
            }

        OldColwyn ->
            { name = "Old Colwyn"
            , wikipedia = "Old_Colwyn"
            }

        Penmaenmawr ->
            { name = "Penmaenmawr"
            , wikipedia = "Penmaenmawr"
            }

        Towyn ->
            { name = "Towyn"
            , wikipedia = "Towyn"
            }

        Carrog ->
            { name = "Carrog"
            , wikipedia = "Carrog"
            }

        Corwen ->
            { name = "Corwen"
            , wikipedia = "Corwen"
            }

        Denbigh ->
            { name = "Denbigh"
            , wikipedia = "Denbigh"
            }

        Gellifor ->
            { name = "Gellifor"
            , wikipedia = "Gellifor"
            }

        Llangollen ->
            { name = "Llangollen"
            , wikipedia = "Llangollen"
            }

        Prestatyn ->
            { name = "Prestatyn"
            , wikipedia = "Prestatyn"
            }

        Rhuddlan ->
            { name = "Rhuddlan"
            , wikipedia = "Rhuddlan"
            }

        Rhyl ->
            { name = "Rhyl"
            , wikipedia = "Rhyl"
            }

        Ruthin ->
            { name = "Ruthin"
            , wikipedia = "Ruthin"
            }

        StAsaph ->
            { name = "St Asaph"
            , wikipedia = "St_Asaph"
            }

        Bagallit ->
            { name = "Bagallit"
            , wikipedia = "Bagallit"
            }

        Broughton ->
            { name = "Broughton"
            , wikipedia = "Broughton"
            }

        Buckley ->
            { name = "Buckley"
            , wikipedia = "Buckley"
            }

        Caerwys ->
            { name = "Caerwys"
            , wikipedia = "Caerwys"
            }

        ConnahsQuay ->
            { name = "Connahs Quay"
            , wikipedia = "Connahs_Quay"
            }

        Ewole ->
            { name = "Ewole"
            , wikipedia = "Ewole"
            }

        Flint ->
            { name = "Flint"
            , wikipedia = "Flint"
            }

        Hawarden ->
            { name = "Hawarden"
            , wikipedia = "Hawarden"
            }

        Holywell ->
            { name = "Holywell"
            , wikipedia = "Holywell"
            }

        Mold ->
            { name = "Mold"
            , wikipedia = "Mold"
            }

        Queensferry ->
            { name = "Queensferry"
            , wikipedia = "Queensferry"
            }

        Saltney ->
            { name = "Saltney"
            , wikipedia = "Saltney"
            }

        Shotton ->
            { name = "Shotton"
            , wikipedia = "Shotton"
            }

        Abertillery ->
            { name = "Abertillery"
            , wikipedia = "Abertillery"
            }

        Blaina ->
            { name = "Blaina"
            , wikipedia = "Blaina"
            }

        Brynmawr ->
            { name = "Brynmawr"
            , wikipedia = "Brynmawr"
            }

        Cwmbran ->
            { name = "Cwmbran"
            , wikipedia = "Cwmbran"
            }

        EbbwVale ->
            { name = "Ebbw Vale"
            , wikipedia = "Ebbw_Vale"
            }

        Newport ->
            { name = "Newport"
            , wikipedia = "Newport,_Wales"
            }

        Tafarnaubach ->
            { name = "Tafarnaubach"
            , wikipedia = "Tafarnaubach"
            }

        Tredegar ->
            { name = "Tredegar"
            , wikipedia = "Tredegar"
            }

        Bala ->
            { name = "Bala"
            , wikipedia = "Bala,_Gwynedd"
            }

        Bangor ->
            { name = "Bangor"
            , wikipedia = "Bangor"
            }

        Barmouth ->
            { name = "Barmouth"
            , wikipedia = "Barmouth"
            }

        BetwsyCoed ->
            { name = "Betws y Coed"
            , wikipedia = "Betws-y-Coed"
            }

        BlaenauFfestiniog ->
            { name = "Blaenau Ffestiniog"
            , wikipedia = "Blaenau_Ffestiniog"
            }

        Caernarfon ->
            { name = "Caernarfon"
            , wikipedia = "Caernarfon"
            }

        Conwy ->
            { name = "Conwy"
            , wikipedia = "Conwy"
            }

        Criccieth ->
            { name = "Criccieth"
            , wikipedia = "Criccieth"
            }

        Dolgellau ->
            { name = "Dolgellau"
            , wikipedia = "Dolgellau"
            }

        Ffestiniog ->
            { name = "Ffestiniog"
            , wikipedia = "Ffestiniog"
            }

        Harlech ->
            { name = "Harlech"
            , wikipedia = "Harlech"
            }

        Llanberis ->
            { name = "Llanberis"
            , wikipedia = "Llanberis"
            }

        Llanfachreth ->
            { name = "Llanfachreth"
            , wikipedia = "Llanfachreth"
            }

        Nefyn ->
            { name = "Nefyn"
            , wikipedia = "Nefyn"
            }

        Porthmadog ->
            { name = "Porthmadog"
            , wikipedia = "Porthmadog"
            }

        Pwllheli ->
            { name = "Pwllheli"
            , wikipedia = "Pwllheli"
            }

        Tywyn ->
            { name = "Tywyn"
            , wikipedia = "Tywyn"
            }

        YFelinheli ->
            { name = "Y Felinheli"
            , wikipedia = "Y_Felinheli"
            }

        Aberdare ->
            { name = "Aberdare"
            , wikipedia = "Aberdare"
            }

        Bridgend ->
            { name = "Bridgend"
            , wikipedia = "Bridgend"
            }

        Caerphilly ->
            { name = "Caerphilly"
            , wikipedia = "Caerphilly"
            }

        Llantrisant ->
            { name = "Llantrisant"
            , wikipedia = "Llantrisant"
            }

        Maesteg ->
            { name = "Maesteg"
            , wikipedia = "Maesteg"
            }

        MerthyrTydfil ->
            { name = "Merthyr Tydfil"
            , wikipedia = "Merthyr_Tydfil"
            }

        Pontypridd ->
            { name = "Pontypridd"
            , wikipedia = "Pontypridd"
            }

        Porth ->
            { name = "Porth"
            , wikipedia = "Porth"
            }

        Porthcawl ->
            { name = "Porthcawl"
            , wikipedia = "Porthcawl"
            }

        Abergavenny ->
            { name = "Abergavenny"
            , wikipedia = "Abergavenny"
            }

        Caldicot ->
            { name = "Caldicot"
            , wikipedia = "Caldicot"
            }

        Chepstow ->
            { name = "Chepstow"
            , wikipedia = "Chepstow"
            }

        Monmouth ->
            { name = "Monmouth"
            , wikipedia = "Monmouth"
            }

        Usk ->
            { name = "Usk"
            , wikipedia = "Usk"
            }

        Fishguard ->
            { name = "Fishguard"
            , wikipedia = "Fishguard"
            }

        Goodwick ->
            { name = "Goodwick"
            , wikipedia = "Goodwick"
            }

        Hakin ->
            { name = "Hakin"
            , wikipedia = "Hakin"
            }

        Haverfordwest ->
            { name = "Haverfordwest"
            , wikipedia = "Haverfordwest"
            }

        MilfordHaven ->
            { name = "Milford Haven"
            , wikipedia = "Milford_Haven"
            }

        Narberth ->
            { name = "Narberth"
            , wikipedia = "Narberth"
            }

        Neyland ->
            { name = "Neyland"
            , wikipedia = "Neyland"
            }

        Pembroke ->
            { name = "Pembroke"
            , wikipedia = "Pembroke"
            }

        PembrokeDock ->
            { name = "Pembroke Dock"
            , wikipedia = "Pembroke_Dock"
            }

        StDavids ->
            { name = "St Davids"
            , wikipedia = "St_Davids"
            }

        Tenby ->
            { name = "Tenby"
            , wikipedia = "Tenby"
            }

        Brecon ->
            { name = "Brecon"
            , wikipedia = "Brecon"
            }

        BuilthWells ->
            { name = "Builth Wells"
            , wikipedia = "Builth_Wells"
            }

        Cefnllys ->
            { name = "Cefnllys"
            , wikipedia = "Cefnllys"
            }

        Crickhowell ->
            { name = "Crickhowell"
            , wikipedia = "Crickhowell"
            }

        HayOnWye ->
            { name = "Hay on Wye"
            , wikipedia = "Hay-on-Wye"
            }

        Knighton ->
            { name = "Knighton"
            , wikipedia = "Knighton"
            }

        LlandrindodWells ->
            { name = "Llandrindod Wells"
            , wikipedia = "Llandrindod_Wells"
            }

        LlanfairCaereinion ->
            { name = "Llanfair Caereinion"
            , wikipedia = "Llanfair_Caereinion"
            }

        Llanfyllin ->
            { name = "Llanfyllin"
            , wikipedia = "Llanfyllin"
            }

        Llangors ->
            { name = "Llangors"
            , wikipedia = "Llangors"
            }

        Llanidloes ->
            { name = "Llanidloes"
            , wikipedia = "Llanidloes"
            }

        LlanwrtydWells ->
            { name = "Llanwrtyd Wells"
            , wikipedia = "Llanwrtyd_Wells"
            }

        Machynlleth ->
            { name = "Machynlleth"
            , wikipedia = "Machynlleth"
            }

        Montgomery ->
            { name = "Montgomery"
            , wikipedia = "Montgomery"
            }

        Newtown ->
            { name = "Newtown"
            , wikipedia = "Newtown"
            }

        OldRadnor ->
            { name = "Old Radnor"
            , wikipedia = "Old_Radnor"
            }

        Presteigne ->
            { name = "Presteigne"
            , wikipedia = "Presteigne"
            }

        Rhayader ->
            { name = "Rhayader"
            , wikipedia = "Rhayader"
            }

        Talgarth ->
            { name = "Talgarth"
            , wikipedia = "Talgarth"
            }

        Welshpool ->
            { name = "Welshpool"
            , wikipedia = "Welshpool"
            }

        Barry ->
            { name = "Barry"
            , wikipedia = "Barry"
            }

        Cardiff ->
            { name = "Cardiff"
            , wikipedia = "Cardiff"
            }

        Cowbridge ->
            { name = "Cowbridge"
            , wikipedia = "Cowbridge"
            }

        LlantwitMajor ->
            { name = "Llantwit Major"
            , wikipedia = "Llantwit_Major"
            }

        Penarth ->
            { name = "Penarth"
            , wikipedia = "Penarth"
            }

        Gorseinon ->
            { name = "Gorseinon"
            , wikipedia = "Gorseinon"
            }

        LliwValey ->
            { name = "Lliw Valey"
            , wikipedia = "Lliw_Valey"
            }

        Neath ->
            { name = "Neath"
            , wikipedia = "Neath"
            }

        PortTalbot ->
            { name = "Port Talbot"
            , wikipedia = "Port_Talbot"
            }

        Swansea ->
            { name = "Swansea"
            , wikipedia = "Swansea"
            }

        Chirk ->
            { name = "Chirk"
            , wikipedia = "Chirk"
            }

        OvertonOnDee ->
            { name = "Overton on Dee"
            , wikipedia = "Overton-on-Dee"
            }

        Rhosllannerchrugog ->
            { name = "Rhosllannerchrugog"
            , wikipedia = "Rhosllannerchrugog"
            }

        Rhosnesni ->
            { name = "Rhosnesni"
            , wikipedia = "Rhosnesni"
            }

        Wrexham ->
            { name = "Wrexham"
            , wikipedia = "Wrexham"
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
        |> insert "amlwch" Amlwch
        |> insert "beaumaris" Beaumaris
        |> insert "benllech" Benllech
        |> insert "holyhead" Holyhead
        |> insert "llanfairpwllgwyngyll" Llanfairpwllgwyngyll
        |> insert "llangefni" Llangefni
        |> insert "menaibridge" MenaiBridge
        |> insert "ammanford" Ammanford
        |> insert "burryport" BurryPort
        |> insert "carmarthen" Carmarthen
        |> insert "garnant" Garnant
        |> insert "glanamman" Glanamman
        |> insert "kidwelly" Kidwelly
        |> insert "laugharne" Laugharne
        |> insert "llandeilo" Llandeilo
        |> insert "llandovery" Llandovery
        |> insert "llanelli" Llanelli
        |> insert "newcastleemlyn" NewcastleEmlyn
        |> insert "stclears" StClears
        |> insert "whitland" Whitland
        |> insert "aberaeron" Aberaeron
        |> insert "aberystwyth" Aberystwyth
        |> insert "cardigan" Cardigan
        |> insert "lampeter" Lampeter
        |> insert "llandysul" Llandysul
        |> insert "newquay" NewQuay
        |> insert "tregaron" Tregaron
        |> insert "abergele" Abergele
        |> insert "colwynbay" ColwynBay
        |> insert "conwy" Conwy
        |> insert "deganwy" Deganwy
        |> insert "llandudno" Llandudno
        |> insert "llandudnojunction" LlandudnoJunction
        |> insert "llanfairfechan" Llanfairfechan
        |> insert "llanrwst" Llanrwst
        |> insert "oldcolwyn" OldColwyn
        |> insert "penmaenmawr" Penmaenmawr
        |> insert "towyn" Towyn
        |> insert "carrog" Carrog
        |> insert "corwen" Corwen
        |> insert "denbigh" Denbigh
        |> insert "gellifor" Gellifor
        |> insert "llangollen" Llangollen
        |> insert "prestatyn" Prestatyn
        |> insert "rhuddlan" Rhuddlan
        |> insert "rhyl" Rhyl
        |> insert "ruthin" Ruthin
        |> insert "stasaph" StAsaph
        |> insert "bagallit" Bagallit
        |> insert "broughton" Broughton
        |> insert "buckley" Buckley
        |> insert "caerwys" Caerwys
        |> insert "connahsquay" ConnahsQuay
        |> insert "ewole" Ewole
        |> insert "flint" Flint
        |> insert "hawarden" Hawarden
        |> insert "holywell" Holywell
        |> insert "mold" Mold
        |> insert "queensferry" Queensferry
        |> insert "saltney" Saltney
        |> insert "shotton" Shotton
        |> insert "abertillery" Abertillery
        |> insert "blaina" Blaina
        |> insert "brynmawr" Brynmawr
        |> insert "cwmbran" Cwmbran
        |> insert "ebbwvale" EbbwVale
        |> insert "tafarnaubach" Tafarnaubach
        |> insert "tredegar" Tredegar
        |> insert "bala" Bala
        |> insert "bangor" Bangor
        |> insert "barmouth" Barmouth
        |> insert "betwsycoed" BetwsyCoed
        |> insert "blaenauffestiniog" BlaenauFfestiniog
        |> insert "caernarfon" Caernarfon
        |> insert "criccieth" Criccieth
        |> insert "dolgellau" Dolgellau
        |> insert "ffestiniog" Ffestiniog
        |> insert "harlech" Harlech
        |> insert "llanberis" Llanberis
        |> insert "llanfachreth" Llanfachreth
        |> insert "nefyn" Nefyn
        |> insert "porthmadog" Porthmadog
        |> insert "pwllheli" Pwllheli
        |> insert "tywyn" Tywyn
        |> insert "yfelinheli" YFelinheli
        |> insert "aberdare" Aberdare
        |> insert "bridgend" Bridgend
        |> insert "caerphilly" Caerphilly
        |> insert "llantrisant" Llantrisant
        |> insert "maesteg" Maesteg
        |> insert "merthyrtydfil" MerthyrTydfil
        |> insert "pontypridd" Pontypridd
        |> insert "porth" Porth
        |> insert "porthcawl" Porthcawl
        |> insert "abergavenny" Abergavenny
        |> insert "caldicot" Caldicot
        |> insert "chepstow" Chepstow
        |> insert "monmouth" Monmouth
        |> insert "usk" Usk
        |> insert "fishguard" Fishguard
        |> insert "goodwick" Goodwick
        |> insert "hakin" Hakin
        |> insert "haverfordwest" Haverfordwest
        |> insert "milfordhaven" MilfordHaven
        |> insert "narberth" Narberth
        |> insert "newport" Newport
        |> insert "neyland" Neyland
        |> insert "pembroke" Pembroke
        |> insert "pembrokedock" PembrokeDock
        |> insert "stdavids" StDavids
        |> insert "tenby" Tenby
        |> insert "brecon" Brecon
        |> insert "builthwells" BuilthWells
        |> insert "cefnllys" Cefnllys
        |> insert "crickhowell" Crickhowell
        |> insert "hayonwye" HayOnWye
        |> insert "knighton" Knighton
        |> insert "llandrindodwells" LlandrindodWells
        |> insert "llanfaircaereinion" LlanfairCaereinion
        |> insert "llanfyllin" Llanfyllin
        |> insert "llangors" Llangors
        |> insert "llanidloes" Llanidloes
        |> insert "llanwrtydwells" LlanwrtydWells
        |> insert "machynlleth" Machynlleth
        |> insert "montgomery" Montgomery
        |> insert "newtown" Newtown
        |> insert "oldradnor" OldRadnor
        |> insert "presteigne" Presteigne
        |> insert "rhayader" Rhayader
        |> insert "talgarth" Talgarth
        |> insert "welshpool" Welshpool
        |> insert "barry" Barry
        |> insert "cardiff" Cardiff
        |> insert "cowbridge" Cowbridge
        |> insert "llantwitmajor" LlantwitMajor
        |> insert "penarth" Penarth
        |> insert "gorseinon" Gorseinon
        |> insert "lliwvaley" LliwValey
        |> insert "neath" Neath
        |> insert "porttalbot" PortTalbot
        |> insert "swansea" Swansea
        |> insert "chirk" Chirk
        |> insert "overtonondee" OvertonOnDee
        |> insert "rhosllannerchrugog" Rhosllannerchrugog
        |> insert "rhosnesni" Rhosnesni
        |> insert "wrexham" Wrexham
