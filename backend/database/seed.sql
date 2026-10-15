-- ==========================================================
-- The Torque Studio — Database Seed Data
-- Populates all 6 Categories, 22 Services, Site Settings, FAQs, Gallery Items & Admin
-- ==========================================================

USE `the_torque_studio`;

-- ----------------------------------------------------------
-- 1. Insert Service Categories
-- ----------------------------------------------------------
INSERT INTO `service_categories` (`id`, `name`, `slug`, `description`, `sort_order`) VALUES
(1, 'Paint Protection', 'paint-protection', 'Advanced nanotech coatings and self-healing films designed to protect your vehicle paint from environmental hazards, UV rays, and swirl marks.', 1),
(2, 'Paint Correction and Polishing', 'paint-correction-and-polishing', 'Multi-stage machine compounding and finishing to eliminate micro-scratches, oxidation, and restore deep optical clarity to clear coats.', 2),
(3, 'Exterior Cleaning', 'exterior-cleaning', 'Touch-safe decontamination, pH-neutral snow foams, and meticulous two-bucket exterior washing techniques.', 3),
(4, 'Interior Detailing', 'interior-detailing', 'Comprehensive cabin restoration, leather rejuvenation, deep upholstery extraction, and germ-neutralizing dry cleaning.', 4),
(5, 'Wheels and Accessories', 'wheels-and-accessories', 'Dedicated wheel barrel decontamination, iron fallout removal, glass clarifying, and tyre dressings.', 5),
(6, 'Convenience Services', 'convenience-services', 'Hassle-free vehicle logistics including safe pick-up, precision delivery, and concierge customer care.', 6);

-- ----------------------------------------------------------
-- 2. Insert All 22 Services
-- ----------------------------------------------------------
INSERT INTO `services` (
    `id`, `category_id`, `name`, `slug`, `short_description`, `full_description`,
    `benefits`, `process`, `included_tasks`, `suitable_vehicles`,
    `featured_image`, `gallery_images`, `faqs`, `related_service_ids`,
    `meta_title`, `meta_description`, `canonical_url`,
    `is_featured`, `is_published`, `sort_order`
) VALUES
-- 1. Polishing
(
    1, 2, 'Polishing', 'polishing',
    'Single-stage machine polishing designed to eliminate light hazing, boost gloss levels, and restore depth to clear coats.',
    'Our professional polishing service utilizes precision dual-action polishers matched with finishing pads and micro-abrasive polishes. It gently removes light surface defects and enhances the reflective depth of your paintwork before protection layers are applied.',
    '["Enhances mirror-like gloss and paint depth", "Removes light hazing and wash marring", "Safe, non-aggressive clear coat refinement", "Ideal preparation for sealants or waxes"]',
    '["Thorough pH-neutral hand wash and paint decontamination", "Clay bar treatment to remove bonded contaminants", "Paint depth gauge readings across all metal panels", "Precision dual-action machine polishing with micro-finishing polish", "Residue wipe-down with isopropyl alcohol inspection spray"]',
    '["Foam wash & rinse", "Surface decontamination", "Panel tape masking", "Single-stage machine polish", "High-gloss inspection"]',
    '["Luxury Sedans", "Sports Coupes", "Premium SUVs", "Vintage Classics"]',
    '/assets/services/polishing.jpg',
    '["/assets/services/polishing.jpg", "/assets/services/rubbing-polishing.jpg"]',
    '[{"q": "How long does a polishing treatment take?", "a": "Typically 3 to 5 hours depending on vehicle dimensions and paint condition."}]',
    '[5, 22, 4]',
    'Professional Car Polishing in Tilak Nagar, New Delhi | The Torque Studio',
    'Boost paint gloss and eliminate light surface hazing with single-stage machine polishing at The Torque Studio, Tilak Nagar, West Delhi.',
    '/services/polishing',
    1, 1, 1
),

-- 2. Car Window Cleaning
(
    2, 5, 'Car Window Cleaning', 'car-window-cleaning',
    'Streak-free optical clarity treatment for all interior and exterior glass, eliminating road films, water marks, and haze.',
    'Road grime, oily windshield films, and mineral deposits degrade visibility and driver safety. Our window cleaning service uses ammonia-free, tint-safe glass cleansers combined with waffle-weave microfiber towels to deliver pristine optical clarity inside and out.',
    '["Crystal-clear vision in day and nighttime driving", "Removes stubborn water spotting and smoker haze", "Completely safe for factory and aftermarket window tints", "Hydrophobic glass prep for wet-weather driving"]',
    '["Pre-wash dirt removal from glass perimeters and rubber seals", "Application of professional tint-safe glass clarifying solution", "Agitation of mineral marks with specialized glass-safe pads", "Double-wipe with ultra-plush waffle-weave microfibers", "Inspection under studio inspection lighting"]',
    '["Windshield deep clean", "Side windows interior/exterior", "Rear windshield defogger safe clean", "Sunroof & moonroof treatment"]',
    '["All Passenger Cars", "SUVs", "Commercial Luxury Fleets"]',
    '/assets/services/window-cleaning.jpg',
    '["/assets/services/window-cleaning.jpg"]',
    '[{"q": "Will this harm aftermarket window films?", "a": "No, our solutions are 100% ammonia-free and safe for high-grade solar tints."}]',
    '[3, 16]',
    'Streak-Free Car Window Cleaning in West Delhi | The Torque Studio',
    'Restore total optical glass clarity and eliminate stubborn road films with streak-free automotive window cleaning in Tilak Nagar, New Delhi.',
    '/services/car-window-cleaning',
    0, 1, 2
),

-- 3. Pressure Car Washing
(
    3, 3, 'Pressure Car Washing', 'pressure-car-washing',
    'Calibrated high-pressure touchless rinse and snow foam bath targeting wheel arches, underbody, and stubborn traffic films.',
    'High-pressure washing at The Torque Studio is engineered for maximum dirt release with zero paint marring. Utilizing temperature-balanced pressure nozzles and thick foam pre-soaks, road dirt and grit are emulsified and rinsed away before any contact wash takes place.',
    '["Safely lifts abrasive grit without rubbing against paint", "Flushes salt, grime, and mud from wheel wells and undercarriage", "Thick dense foam dwell time breaks down oily road residues", "Saves water through calibrated high-efficiency pressure systems"]',
    '["Touchless high-pressure rinse to blast away loose grit", "Heavy pH-neutral snow foam bath covering vehicle exterior", "Gentle agitation of emblems, grilles, and fuel door with boars-hair brushes", "Targeted undercarriage and inner wheel arch high-pressure flushing", "Filtered final rinse and scratch-free blow drying"]',
    '["Touchless pre-rinse", "Snow foam dwell", "Wheel arch flush", "Emblem detailing", "Filtered spot-free rinse"]',
    '["Hatchbacks", "Sedans", "Compact SUVs", "Full-Size 4x4s"]',
    '/assets/services/pressure-wash.jpg',
    '["/assets/services/pressure-wash.jpg"]',
    '[{"q": "Can pressure washing damage sensitive sensors or paint?", "a": "We maintain calibrated pressure limits and safe nozzle distances strictly suited for automotive clear coats."}]',
    '[16, 6, 13]',
    'High Pressure Car Washing in Tilak Nagar | The Torque Studio',
    'Experience safe high-pressure touchless pre-wash and snow foam cleaning at The Torque Studio in New Mahavir Nagar, Tilak Nagar.',
    '/services/pressure-car-washing',
    1, 1, 3
),

-- 4. Car Waxing
(
    4, 1, 'Car Waxing', 'car-waxing',
    'Application of premium Carnauba and synthetic paste waxes for warm organic reflections and hydrophobic water-beading protection.',
    'For enthusiasts who cherish deep, warm, liquid-wet reflections, hand waxing provides an incomparable optical finish. Our waxing service seals the paint with ultra-pure Brazilian Carnauba or synthetic hybrid polymers to shield against light contamination and environmental fallout.',
    '["Warm, wet-look depth especially stunning on dark paint colors", "Hydrophobic surface creates tight, satisfying water beads", "Sacrificial protective shield against UV light and pollen", "Hand-buffed to a silky, tactile smoothness"]',
    '["Decontaminating foam wash and surface prep", "Gentle paint cleansing lotion to ensure pristine wax adhesion", "Uniform thin application of premium carnauba paste wax by hand", "Cure time monitoring in temperature-regulated studio", "Microfiber buffing under cross-lighting for uniform gloss"]',
    '["Exterior hand wash", "Pre-wax paint cleansing", "Hand paste wax application", "Panel edge buffing", "Trim dressing"]',
    '["Show Cars", "Sports Cars", "Weekend Cruisers", "All Vehicles"]',
    '/assets/services/car-waxing.jpg',
    '["/assets/services/car-waxing.jpg"]',
    '[{"q": "How does wax compare to ceramic coating?", "a": "Wax yields an organic warm glow lasting 2-3 months, whereas ceramic coatings bond molecularly for multiple years."}]',
    '[1, 5, 17]',
    'Premium Car Waxing Service Tilak Nagar | The Torque Studio',
    'Hand-applied carnauba and synthetic car waxing for brilliant liquid reflections and UV protection in New Delhi.',
    '/services/car-waxing',
    0, 1, 4
),

-- 5. Car Polishing
(
    5, 2, 'Car Polishing', 'car-polishing',
    'Comprehensive multi-tier paint polishing to restore brilliant clarity, remove moderate wash marks, and enhance color vibrancy.',
    'Everyday washing and sun exposure take a toll on vehicle clear coats, leaving behind fine swirl marks and dullness. Our dedicated car polishing service rejuvenates paint by smoothing out micro-imperfections, producing a radiant showroom finish across every body panel.',
    '["Reverses noticeable swirl marks and spiderweb scratches", "Brings out true color saturation and metallic flake pop", "Levels microscopic peaks and valleys for mirror reflections", "Significantly increases vehicle cosmetic resale value"]',
    '["Two-bucket hand wash and chemical iron decontamination", "Clay bar glide across all panels", "Paint thickness inspection and test spot calibration", "Medium-cut and fine-cut polishing using dual-action machinery", "Residue removal and optical gloss verification"]',
    '["Full paint decontamination", "Dual-action machine polish", "Headlight lens light polish", "Pillar gloss polish", "Final gloss wipe"]',
    '["All Luxury & Everyday Vehicles", "Sedans", "SUVs"]',
    '/assets/services/car-polishing.jpg',
    '["/assets/services/car-polishing.jpg"]',
    '[{"q": "Is machine polishing safe for thin factory paint?", "a": "Yes, we monitor panel thickness with digital ultrasonic gauges to ensure safe, controlled clear coat conservation."}]',
    '[1, 22, 17]',
    'Comprehensive Car Polishing in West Delhi | The Torque Studio',
    'Professional multi-step car polishing to eliminate swirls and restore deep gloss in Tilak Nagar, New Delhi.',
    '/services/car-polishing',
    1, 1, 5
),

-- 6. Clay Bar Treatment
(
    6, 3, 'Clay Bar Treatment', 'clay-bar-treatment',
    'Mechanical paint decontamination to safely extract embedded industrial fallout, tree sap, rail dust, and overspray.',
    'Washing alone cannot remove microscopic particles that embed into your vehicle’s clear coat over time. Our clay bar treatment glides across the paint using specialized lubricants to safely shears off bonded contaminants, leaving panels as smooth as glass.',
    '["Restores baby-smooth tactile feel to rough paint", "Extracts brake dust, rail dust, industrial fallout, and tree sap", "Prevents contaminants from causing clear coat rust pinholes", "Essential prep for wax, sealant, or ceramic bonding"]',
    '["Pre-wash and chemical iron remover dwell to dissolve metallic particles", "Lubrication flood of panel using high-slip detailing spray", "Fine/medium grade clay bar glide in straight-line motions", "Surface inspection using tactile test", "Final rinse and ultra-soft towel drying"]',
    '["Chemical iron fallout removal", "Full-body clay bar pass", "Glass clay treatment", "Paint smooth verification"]',
    '["Vehicles driven regularly in city/highway traffic", "New and used vehicles"]',
    '/assets/services/clay-bar.jpg',
    '["/assets/services/clay-bar.jpg"]',
    '[{"q": "How can I tell if my car needs a clay bar treatment?", "a": "After washing, place your hand inside a thin plastic bag and gently rub the paint. If it feels gritty like sandpaper, it needs claying."}]',
    '[3, 1, 17]',
    'Automotive Clay Bar Treatment in Tilak Nagar | The Torque Studio',
    'Extract stubborn bonded fallout, brake dust, and sap with professional clay bar decontamination in West Delhi.',
    '/services/clay-bar-treatment',
    0, 1, 6
),

-- 7. Interior Cleaning
(
    7, 4, 'Interior Cleaning', 'interior-cleaning',
    'Detailed cabin sanitization and cleansing spanning dashboard, consoles, door cards, foot pedals, and air vents.',
    'Spend your driving hours in a pristine, hygienic sanctuary. Our interior cleaning service targets every crevice of your car cabin, clearing dust, oils, crumbs, and airborne contaminants using pH-neutral interior detailing agents and anti-static conditioners.',
    '["Deep cleansing of all tactile touchpoints and controls", "Leaves non-greasy, matte OEM factory finish on dashboards", "Eliminates stale odours and airborne dust buildup", "Protects plastics and vinyl from UV cracking and fading"]',
    '["High-pressure compressed air purge of vents, seat rails, and tight crevices", "pH-balanced cleaner agitation on steering wheel, console, and door cards", "Cup holder and glovebox deep decontamination", "Air conditioning vent brush detailing and antimicrobial sanitization", "UV-inhibiting matte dressing applied to all vinyl and plastics"]',
    '["Dashboard & console scrub", "Door cards & armrests", "AC vent cleaning", "Pedal box degreasing", "UV matte finish"]',
    '["Family Vehicles", "Daily Commuters", "Luxury Executive Cars"]',
    '/assets/services/interior-cleaning.jpg',
    '["/assets/services/interior-cleaning.jpg"]',
    '[{"q": "Does this leave a slippery, shiny dashboard?", "a": "Never. We strictly use OEM-finish matte conditioners that repel dust without oily gloss or reflections."}]',
    '[8, 9, 10, 12]',
    'Complete Car Interior Cleaning Tilak Nagar | The Torque Studio',
    'Revitalize your car cabin with thorough interior cleaning, vent sanitization, and matte UV protection in New Delhi.',
    '/services/interior-cleaning',
    1, 1, 7
),

-- 8. Vehicle Interior Vacuuming
(
    8, 4, 'Vehicle Interior Vacuuming', 'vehicle-interior-vacuuming',
    'High-suction dual-motor extraction targeting loose dirt, sand, pet hair, and debris from carpets, mats, and seat crevices.',
    'Embedded gravel and sand wear down carpet fibers and trap odours. Our vehicle interior vacuuming utilizes industrial multi-cyclonic suction equipped with slender crevice tools and rotating agitation attachments to pull grit from the deepest carpet nap.',
    '["Pulls deeply embedded grit that standard vacuums miss", "Prevents premature wear of factory carpet pile", "Reaches under seat rails, boot corners, and seat seams", "Quick and thorough turnaround for daily freshness"]',
    '["Removal and dedicated vacuuming of floor mats and boot liner", "Compressed air blow-out to loosen debris trapped under seat rails", "Multi-pass vacuuming of front and rear passenger footwells", "Seat crevice and seat cushion seam vacuuming", "Trunk and spare wheel well vacuuming"]',
    '["Floor carpet vacuum", "Under-seat rail sweep", "Boot / trunk vacuum", "Seat seam debris removal"]',
    '["All Car Types", "SUVs", "Vans"]',
    '/assets/services/interior-vacuuming.jpg',
    '["/assets/services/interior-vacuuming.jpg"]',
    '[{"q": "Can you remove stubborn pet hair?", "a": "Yes, we utilize specialized rubber-blade hair extractors alongside high-suction vacuums."}]',
    '[7, 9, 15]',
    'High-Power Interior Vacuuming in Tilak Nagar | The Torque Studio',
    'Deep-pile carpet and trunk vacuuming removing sand, pet hair, and road grit at The Torque Studio, West Delhi.',
    '/services/vehicle-interior-vacuuming',
    0, 1, 8
),

-- 9. Vehicle Upholstery Cleaning
(
    9, 4, 'Vehicle Upholstery Cleaning', 'vehicle-upholstery-cleaning',
    'Hot-water and foam extraction treatment to lift stubborn drink spills, food stains, and sweat from fabric car seats and liners.',
    'Fabric seats easily absorb perspiration, coffee stains, and road grime. Our upholstery cleaning utilizes fabric-safe enzyme spot removers agitated with soft horsehair brushes, followed by high-power extraction to lift discolouration without over-saturating the seat foam.',
    '["Removes unsightly drink stains, dirt patches, and water rings", "Neutralizes bacteria and unpleasant cabin odours at the root", "Dries clean without stiff chemical residues or discoloration", "Brightens original fabric patterns and textures"]',
    '["Fiber inspection and colorfastness spot test", "Pre-treatment with enzyme stain break-down solution", "Rotary or manual horsehair agitation on fabric seat faces and bolsters", "Heated wet-vacuum extraction pulling soiled liquids into recovery tank", "Air-mover accelerated drying process"]',
    '["Seat fabric deep clean", "Door cloth insert extraction", "Stain spot treatment", "Fabric odor neutralizer"]',
    '["Vehicles with cloth or Alcantara upholstery"]',
    '/assets/services/upholstery-cleaning.jpg',
    '["/assets/services/upholstery-cleaning.jpg"]',
    '[{"q": "How long do the seats take to dry?", "a": "Thanks to powerful extraction and our studio air movers, fabric seats are usually dry within 2 to 3 hours."}]',
    '[7, 8, 12]',
    'Vehicle Fabric Upholstery Cleaning Tilak Nagar | The Torque Studio',
    'Restore stained car seats and fabric liners with deep extraction upholstery cleaning at The Torque Studio, New Delhi.',
    '/services/vehicle-upholstery-cleaning',
    0, 1, 9
),

-- 10. Leather and Suede Cleaning
(
    10, 4, 'Leather and Suede Cleaning', 'leather-and-suede-cleaning',
    'pH-balanced gentle cleansing and conditioning for luxury automotive hides, perforated leather, and delicate synthetic suede.',
    'Modern automotive leather is coated with delicate protective clear finishes that dry out and crack when exposed to body oils and Delhi heat. We use pH-neutral leather foams and natural conditioner balms that replenish suppleness and preserve luxury textures.',
    '["Clears greasy shine and restores natural satin OEM appearance", "Prevents bolsters from drying, hardening, and premature cracking", "Specialized low-moisture technique for sensitive Alcantara/suede", "Provides a breathable barrier against dye transfer from denim"]',
    '["Gentle vacuuming with soft horsehair brush to clear seam debris", "pH-neutral foaming leather cleanser application using soft-bristle detailing brushes", "Gentle agitation lifting embedded sebum and body oils from grain", "Microfiber wipe down leaving zero chemical residue", "Application of nourishing leather cream with UV blockers"]',
    '["Full leather seat cleansing", "Steering wheel degreasing", "Armrest & door panel leather care", "Conditioning balm massage"]',
    '["Luxury Sedans", "Sports Cars", "Vehicles with Leather/Alcantara Interiors"]',
    '/assets/services/leather-cleaning.jpg',
    '["/assets/services/leather-cleaning.jpg"]',
    '[{"q": "Can you clean perforated ventilated seats?", "a": "Yes, we use dense dry foams that do not soak into cooling perforations or electronic seat modules."}]',
    '[7, 9, 14]',
    'Luxury Leather and Suede Cleaning in New Delhi | The Torque Studio',
    'Gentle pH-balanced leather conditioning and suede restoration in Tilak Nagar. Prevent cracking and eliminate greasy shine.',
    '/services/leather-and-suede-cleaning',
    1, 1, 10
),

-- 11. Delivery / Vehicle Delivery
(
    11, 6, 'Delivery / Vehicle Delivery', 'vehicle-delivery',
    'Safe, meticulous vehicle drop-off service bringing your freshly detailed automobile right to your doorstep in New Delhi.',
    'We respect your busy schedule. After your car undergoes studio detailing, our trained drivers carefully deliver your vehicle back to your home or office address in pristine, showroom condition with protective mats and seat covers in place.',
    '["Save valuable time without traveling through traffic", "Delivered with protective steering wheel and floor covers", "Full handover briefing highlighting completed treatments", "Covered transit practices to preserve fresh studio finish"]',
    '["Final quality control inspection in studio light booth", "Installation of temporary steering and seat transit covers", "Careful transit by verified and experienced professional drivers", "Client handover and confirmation of customer satisfaction"]',
    '["Pre-delivery inspection", "Transit protection fitment", "Scheduled doorstep delivery", "Handover review"]',
    '["All Customers in New Delhi and NCR region"]',
    '/assets/services/delivery.jpg',
    '["/assets/services/delivery.jpg"]',
    '[{"q": "What areas in Delhi do you deliver to?", "a": "We service Tilak Nagar, Janakpuri, Rajouri Garden, Vikaspuri, and surrounding West Delhi zones. Contact us to verify your location."}]',
    '[21, 14]',
    'Car Detailing Doorstep Delivery in New Delhi | The Torque Studio',
    'Experience seamless convenience with professional doorstep vehicle delivery after complete detailing at The Torque Studio.',
    '/services/vehicle-delivery',
    0, 1, 11
),

-- 12. Dry Cleaning
(
    12, 4, 'Dry Cleaning', 'dry-cleaning',
    'Low-moisture steam and chemical dry cleaning targeting ceiling headliners, delicate electronics, and fabric modules.',
    'Certain areas of a vehicle, particularly delicate fabric roof headliners and electronics-heavy consoles, must never be soaked in water. Our dry cleaning process employs regulated low-moisture steam and encapsulation cleansers to dissolve grime safely.',
    '["Zero risk of sagging roof headliner glue or fabric detachment", "Safe around sensitive digital displays, switches, and wiring", "Removes hand smudges, roof liner stains, and airborne pollution", "Fast turn-around with near-zero interior drying wait times"]',
    '["Pre-vacuuming of headliner and sun visors", "Mist application of low-moisture dry-cleaning encapsulation solution", "Gentle micro-sponge blot technique lifting stains vertically", "Dry steam vapor extraction of seat belts and pillar trims", "Ozone / antimicrobial air circulation cycle"]',
    '["Roof headliner dry clean", "Pillar trims & sun visors", "Seatbelt tensioner wipe", "Electronic console safe clean"]',
    '["All Vehicles, especially those with stained headliners"]',
    '/assets/services/dry-cleaning.jpg',
    '["/assets/services/dry-cleaning.jpg"]',
    '[{"q": "Will my roof liner sag from moisture?", "a": "No, our encapsulation and low-moisture methods are specially designed to safeguard delicate headliner adhesive bonds."}]',
    '[7, 9, 10]',
    'Automotive Interior Dry Cleaning Tilak Nagar | The Torque Studio',
    'Low-moisture car dry cleaning for delicate roof headliners, seatbelts, and electronics in Tilak Nagar, New Delhi.',
    '/services/dry-cleaning',
    0, 1, 12
),

-- 13. Rim and Wheel Cleaning
(
    13, 5, 'Rim and Wheel Cleaning', 'rim-and-wheel-cleaning',
    'Intensive decontamination removing burnt-on brake dust, iron deposits, and road tar from alloys, calipers, and tyre walls.',
    'Wheels endure the harshest driving conditions, accumulating corrosive metallic brake dust and highway tar. Our rim and wheel cleaning utilizes color-changing iron decon gels, dedicated barrel brushes, and tyre degreasers to restore factory luster.',
    '["Dissolves sintered metallic brake dust before it etches alloy clear coat", "Cleans deep into inner wheel barrels and behind spokes", "Degreases browned tyre sidewalls to allow dressings to adhere properly", "Includes brake caliper cleaning and satin tyre protection"]',
    '["Non-acid wheel face and inner barrel pre-soak with iron-active fallout remover", "Colour-changing indicator reaction highlights iron dissolution", "Agitation with soft microfiber wheel wands and lug nut brushes", "High-pressure rinse clearing inner barrel contamination", "Tyre wall scrubbing and application of deep-black UV protectant"]',
    '["Inner barrel deep clean", "Spoke & lug nut detailing", "Brake caliper rinse", "Tyre scrub & dressing"]',
    '["All Wheels (Painted, Diamond-Cut, Matte, Forged Alloys)"]',
    '/assets/services/rim-cleaning.jpg',
    '["/assets/services/rim-cleaning.jpg"]',
    '[{"q": "Is the wheel cleaner safe for expensive diamond-cut or matte rims?", "a": "Yes, we exclusively use non-acidic, pH-neutral iron fall-out cleansers that do not damage sensitive coatings."}]',
    '[3, 16, 17]',
    'Alloy Rim and Wheel Deep Cleaning West Delhi | The Torque Studio',
    'Deep wheel barrel brake dust decontamination and tyre rejuvenation at The Torque Studio, Tilak Nagar.',
    '/services/rim-and-wheel-cleaning',
    0, 1, 13
),

-- 14. Auto Detailing
(
    14, 2, 'Auto Detailing', 'auto-detailing',
    'Comprehensive multi-point transformation combining complete exterior paint refinement and deep interior cabin restoration.',
    'Auto detailing at The Torque Studio represents the pinnacle of vehicle preservation. Combining our full suite of exterior wash, chemical decontamination, machine paint polishing, and interior restoration, your vehicle undergoes a systematic multi-point enhancement.',
    '["Complete head-to-toe renewal of your automobile inside and out", "Brings vehicle aesthetic condition back to showroom standards", "Protects exterior clear coats and interior materials from degradation", "Detailed by trained automotive artisans using specialized equipment"]',
    '["Multi-stage decontamination wash and clay bar treatment", "Multi-point machine paint correction and swirl reduction", "Exhaust tips, emblems, grilles, and rubber seal restoration", "Deep interior vacuuming, leather/fabric cleaning, and steam sanitization", "High-grade paint sealant and long-lasting glass hydrophobic treatment"]',
    '["Complete exterior detail", "Machine paint refinement", "Deep interior overhaul", "Engine bay aesthetic tidy", "Sealant application"]',
    '["Luxury Sedans", "Exotics", "SUVs", "Prestige Vehicles"]',
    '/assets/services/auto-detailing.jpg',
    '["/assets/services/auto-detailing.jpg", "/assets/services/polishing.jpg"]',
    '[{"q": "How long does a full auto detailing package take?", "a": "A full detail typically requires 1 to 2 full studio days for meticulous completion."}]',
    '[1, 7, 17, 19]',
    'Comprehensive Auto Detailing in New Delhi | The Torque Studio',
    'Complete automotive detailing package in Tilak Nagar. Full exterior paint correction and luxury cabin restoration.',
    '/services/auto-detailing',
    1, 1, 14
),

-- 15. Vacuuming
(
    15, 4, 'Vacuuming', 'vacuuming',
    'Quick-turnaround dry suction sweep of footwells, passenger seats, and floor mats for routine interior maintenance.',
    'Designed for regular maintenance between comprehensive details, our vacuuming service rapidly removes daily dust, street dirt, and crumbs from seating areas and foot mats to keep your daily ride clean and respectable.',
    '["Fast turnaround service ideal during routine washes", "Keeps carpets and mats free from abrasive dirt accumulation", "Fresh and presentable cabin for daily commuting"]',
    '["Floor mat removal and dry shake-out", "Focused vacuuming of floorboards and passenger foot areas", "Seat face vacuum sweep", "Re-installation of clean floor mats"]',
    '["Footwell vacuum", "Floor mat dusting", "Seat surface sweep"]',
    '["All Passenger Vehicles"]',
    '/assets/services/interior-vacuuming.jpg',
    '["/assets/services/interior-vacuuming.jpg"]',
    '[{"q": "How long does standard vacuuming take?", "a": "Approximately 15 to 25 minutes."}]',
    '[8, 7, 16]',
    'Routine Car Vacuuming Service Tilak Nagar | The Torque Studio',
    'Fast and effective vehicle cabin vacuuming in West Delhi for a clean everyday commute.',
    '/services/vacuuming',
    0, 1, 15
),

-- 16. Car Washing
(
    16, 3, 'Car Washing', 'car-washing',
    'Gentle two-bucket hand wash with pH-neutral shampoo, soft microfiber mitts, and warm filtered water for swirl-free cleanliness.',
    'Traditional roadside car washes with dirty rags cause severe swirl marks. At The Torque Studio, our two-bucket wash utilizes grit guards, ultra-soft microfiber wash mitts, and premium lubricated shampoos to ensure your clear coat remains pristine and glossy.',
    '["100% swirl-free two-bucket wash technique with grit guards", "pH-balanced shampoos that do not strip existing waxes or coatings", "Soft detailing brushes for grilles, badges, and window moldings", "Touchless warm air drying to prevent towel-induced friction"]',
    '["Pre-rinse to flush away surface grit", "Thick lubricating snow foam pre-soak", "Two-bucket hand wash using dedicated plush microfibers", "Separate buckets and mitts for wheels and lower sills", "Filtered spot-free rinse and filtered blow dry"]',
    '["Foam soak", "Hand wash with grit guards", "Door jamb wipe", "Blow dry & tire shine"]',
    '["All Vehicles"]',
    '/assets/services/car-washing.jpg',
    '["/assets/services/car-washing.jpg"]',
    '[{"q": "Does your car wash strip my existing ceramic coating?", "a": "No, our pH-neutral wash shampoo is specifically engineered to be 100% safe for ceramic coatings, PPF, and waxes."}]',
    '[3, 6, 13]',
    'Premium Hand Car Wash in Tilak Nagar, New Delhi | The Torque Studio',
    'Safe two-bucket swirl-free hand car washing with pH-neutral snow foam in Tilak Nagar, West Delhi.',
    '/services/car-washing',
    1, 1, 16
),

-- 17. Ceramic Coating
(
    17, 1, 'Ceramic Coating', 'ceramic-coating',
    'Nanotechnology silica (SiO2) liquid glass layer that chemically bonds to clear coat, offering high gloss and hydrophobic protection.',
    'Ceramic coating provides durable, semi-permanent protection against Delhi’s extreme sunlight, acid rain, bird droppings, and industrial fallout. By forming an inorganic crystal layer over the clear coat, it enhances gloss and repels dirt effortlessly.',
    '["Extreme hydrophobic properties make washing fast and effortless", "Protects against UV oxidation, clear coat fading, and acid rain", "High optical transparency produces intense candy-like gloss", "Durable chemical barrier lasting years under proper maintenance"]',
    '["Full exterior decontamination wash, clay bar, and iron removal", "Paint correction stage to eliminate clear coat imperfections", "Panel wipe using isopropyl alcohol to strip all polishing oils", "Careful cross-hatch hand application of professional ceramic coating", "Infrared curing lamps to accelerate molecular crystal cross-linking"]',
    '["Full paint correction", "Panel prep wipe", "Multi-layer ceramic coating", "Infrared heat cure", "Glass & wheel face coating"]',
    '["Brand New Cars", "Prestige Vehicles", "Sports Cars", "SUVs"]',
    '/assets/services/ceramic-coating.jpg',
    '["/assets/services/ceramic-coating.jpg", "/assets/services/graphene-coating.jpg"]',
    '[{"q": "How does ceramic coating protect my car?", "a": "It cross-links with the clear coat to form a hard, hydrophobic glass shield that prevents environmental fallout from etching the paint."},{"q": "Does ceramic coating prevent stone chips?", "a": "No coating prevents stone chips. For mechanical impact and rock chip defense, we recommend Paint Protection Film (PPF)."}]',
    '[18, 19, 5]',
    'Professional Ceramic Coating in Delhi | The Torque Studio Tilak Nagar',
    'Protect your vehicle with genuine 9H ceramic coating in Tilak Nagar, New Delhi. Unrivaled gloss, UV defense, and self-cleaning water beading.',
    '/services/ceramic-coating',
    1, 1, 17
),

-- 18. Graphene Coating
(
    18, 1, 'Graphene Coating', 'graphene-coating',
    'Next-generation carbon honeycomb coating providing superior heat dissipation, reduced water spotting, and slick surface feel.',
    'Formulated with reduced graphene oxide, graphene coatings represent the pinnacle of liquid paint protection. Graphene’s unique honeycomb matrix lowers surface heat absorption, which significantly reduces the risk of water spot etching under the hot Delhi sun.',
    '["Lower surface temperature reduces stubborn mineral water spotting", "Remarkable contact angle with ultra-fast water sliding effect", "Enhanced antistatic properties repel road dust and airborne pollen", "Silky smooth surface feel with extraordinary dark paint depth"]',
    '["Intensive wash, claying, and chemical decontamination", "Multi-stage machine paint refinement to perfection", "Degreasing solvent wipe down ensuring pure substrate contact", "Even application of graphene matrix coating in temperature-controlled bay", "Infrared heat lamp activation and surface slickness testing"]',
    '["Paint prep & correction", "IPA panel wipe", "Graphene formulation application", "IR curing cycle", "Hydrophobic test"]',
    '["Luxury Sedans", "Black/Dark Vehicles", "Performance Cars", "SUVs"]',
    '/assets/services/graphene-coating.jpg',
    '["/assets/services/graphene-coating.jpg", "/assets/services/ceramic-coating.jpg"]',
    '[{"q": "What is the difference between ceramic and graphene?", "a": "Graphene reduces surface temperature which cuts down on mineral water spotting, and offers higher slickness compared to traditional SiO2 ceramic coatings."}]',
    '[17, 19, 1]',
    'Advanced Graphene Coating in New Delhi | The Torque Studio',
    'Next-gen graphene coating for superior heat reduction, reduced water spotting, and extreme slickness in Tilak Nagar, Delhi.',
    '/services/graphene-coating',
    1, 1, 18
),

-- 19. Paint Protection Film (PPF)
(
    19, 1, 'Paint Protection Film (PPF)', 'paint-protection-film-ppf',
    'Optically clear, self-healing aliphatic polyurethane film providing physical defense against stone chips, scratches, and road debris.',
    'Paint Protection Film (PPF) is the definitive armor for automotive paint. Made of ultra-tough elastomeric polyurethane, it absorbs high-speed impacts from gravel and debris. Swirls and light scratches automatically heal under ambient engine or sunlight warmth.',
    '["Unrivaled physical impact defense against flying stone chips and road gravel", "Self-healing clear coat layer erases light swirl marks under heat", "Stops parking lot scuffs, shopping trolley rubs, and key scratches", "Maintains original factory paint for maximum vehicle resale value"]',
    '["Sterile studio wash, iron fallout extraction, and clay bar decon", "Single-stage polish to ensure clear coat underneath is pristine", "Precision computer-cut templates or custom wrapped edges", "Slip-solution wet alignment and bubble-free squeegee tacking", "Edge wrapping and heat gun curing for seamless, invisible fitment"]',
    '["Paint decontamination", "Template precision cutting", "Wet PPF installation", "Edge wrapping", "Post-heat inspection"]',
    '["High-Performance Cars", "Luxury SUVs", "New Vehicles", "Highway Drivers"]',
    '/assets/services/ppf.jpg',
    '["/assets/services/ppf.jpg", "/assets/services/photochromic-film.jpg"]',
    '[{"q": "How does self-healing PPF work?", "a": "The elastomeric top layer has a high thermal memory. When warm water or sunlight hits the film, micro-swirls and light scratches re-align and disappear."},{"q": "Can PPF be installed on individual sections?", "a": "Yes! Common packages include Front Bumper + Hood (Bikini/Full Front) or Full Body coverage."}]',
    '[20, 17, 18]',
    'Self-Healing Paint Protection Film (PPF) in Delhi | The Torque Studio',
    'Invisible stone chip and scratch defense with premium self-healing PPF installed by certified technicians in Tilak Nagar, New Delhi.',
    '/services/paint-protection-film-ppf',
    1, 1, 19
),

-- 20. Photochromic Film
(
    20, 1, 'Photochromic Film', 'photochromic-film',
    'Smart light-reactive protective film for headlights and panels that transitions from clear in low light to smoked tint under sunlight UV.',
    'Photochromic film pairs the physical impact defense of PPF with smart light adaptation. In nighttime or shaded conditions, your headlight lenses remain 100% optically crystal-clear; when exposed to bright UV sunlight, the film dynamically shifts to a sleek smoked tone.',
    '["Self-tinting smart technology responds dynamically to sunlight UV levels", "Protects expensive modern LED/Matrix headlight lenses from rock chips and pitting", "Maintains 100% nighttime light throw and full driving safety", "Self-healing top coat protects against road grit hazing"]',
    '["Headlight lens restoration and compounding if oxidized", "Surface alcohol cleaning and tack solution preparation", "Precision wet installation of photochromic polyurethane film", "Moisture extraction and perimeter heat bonding", "UV reaction testing with simulated sunlight beam"]',
    '["Lens decontamination", "Smart photochromic wrap", "Edge seal bonding", "UV transition test"]',
    '["Sports Cars", "Prestige Vehicles with LED/Laser Headlights"]',
    '/assets/services/photochromic-film.jpg',
    '["/assets/services/photochromic-film.jpg", "/assets/services/ppf.jpg"]',
    '[{"q": "Does photochromic headlight film reduce nighttime visibility?", "a": "No, the transition requires active UV light. At night, it stays clear, ensuring standard illumination."}]',
    '[19, 17, 2]',
    'Smart Photochromic Headlight Film in Delhi | The Torque Studio',
    'Dynamic light-reactive headlight protection film that shifts from clear to smoked tint in sunlight at The Torque Studio, Tilak Nagar.',
    '/services/photochromic-film',
    1, 1, 20
),

-- 21. Pick-Up and Drop-Off Service
(
    21, 6, 'Pick-Up and Drop-Off Service', 'pickup-and-dropoff-service',
    'Convenient door-to-door vehicle concierge service with GPS tracking and insured transport across West Delhi.',
    'Enjoy detailing without altering your daily schedule. Our logistics team arrives at your designated residence or workplace, performs an initial photographic condition checklist, safely drives your car to our Tilak Nagar studio, and returns it once completed.',
    '["Zero hassle — your car is collected and returned without you leaving home", "Pre-transit photographic condition walk-around recorded on digital manifest", "Covered floor and seat transit protectors installed during transport", "Transparent time-tracking and progress updates throughout the day"]',
    '["Scheduled concierge arrival at client address", "Digital walk-around inspection and client signature confirmation", "Careful transit to The Torque Studio facility in Tilak Nagar", "Full detailing execution as booked", "Return delivery and final satisfaction walk-around"]',
    '["Doorstep pickup", "Condition checklist", "Secure transit", "Showroom return delivery"]',
    '["All Customers in Tilak Nagar, Janakpuri, West Delhi & NCR"]',
    '/assets/services/pickup-dropoff.jpg',
    '["/assets/services/pickup-dropoff.jpg", "/assets/services/delivery.jpg"]',
    '[{"q": "Is my vehicle insured during transit?", "a": "Yes, our drivers are vetted, professionally licensed, and all handling conforms to our strict studio transit protocols."}]',
    '[11, 14]',
    'Car Detailing Pick-Up and Drop-Off West Delhi | The Torque Studio',
    'Convenient vehicle pick-up and drop-off service for detailing in Tilak Nagar and across West Delhi.',
    '/services/pickup-and-dropoff-service',
    0, 1, 21
),

-- 22. Rubbing and Polishing
(
    22, 2, 'Rubbing and Polishing', 'rubbing-and-polishing',
    'Heavy-to-medium compound paint correction to eliminate sanding marks, deep oxidation, and noticeable scratches before jeweling.',
    'When paintwork suffers from stubborn scratches, bird dropping etchings, or dull oxidation, standard polishing is not enough. Our rubbing and polishing process utilizes diminishing micro-compounds and rotary/DA polishers to level out defects before finishing to a high shine.',
    '["Corrects noticeable clear coat scratches, water marks, and oxidation", "Restores neglected paint back to an even, clear, and glossy surface", "Removes paint transfer from light scuffs or gate brushes", "Essential preliminary stage before applying ceramic or graphene coatings"]',
    '["Paint inspection and depth gauge measurement", "Rotary or long-throw DA compounding pass with micro-abrasive rubbing compound", "Dual-action intermediate polishing pass to remove compounding haze", "Jeweling finishing polish to maximize gloss and clarity", "Solvent wipe down to verify true scratch removal"]',
    '["Panel thickness check", "Heavy compounding rubbing", "Intermediate polish", "Jeweling gloss finish", "True-surface wipe"]',
    '["Vehicles with Swirls, Scratches, Oxidation, or Faded Paint"]',
    '/assets/services/rubbing-polishing.jpg',
    '["/assets/services/rubbing-polishing.jpg", "/assets/services/polishing.jpg"]',
    '[{"q": "What is the difference between rubbing and polishing?", "a": "Rubbing uses heavier abrasive compounds to remove deeper scratches and oxidation, whereas polishing uses fine abrasives to refine the surface into a mirror-like shine."}]',
    '[1, 5, 17]',
    'Car Rubbing and Polishing in Tilak Nagar | The Torque Studio',
    'Heavy scratch removal, oxidation correction, and mirror-finish polishing at The Torque Studio in New Mahavir Nagar, West Delhi.',
    '/services/rubbing-and-polishing',
    1, 1, 22
);

-- ----------------------------------------------------------
-- 3. Insert Site Settings
-- ----------------------------------------------------------
INSERT INTO `site_settings` (`setting_key`, `setting_value`) VALUES
('site_name', 'The Torque Studio'),
('tagline', 'Precision in Every Detail. Perfection in Every Drive.'),
('supporting_headline', 'Protect Your Paint. Elevate Your Drive.'),
('hero_eyebrow', 'PREMIUM AUTOMOTIVE DETAILING · NEW DELHI'),
('hero_title', 'Your Car Deserves Nothing Less Than Perfection.'),
('hero_description', 'From precision detailing and paint correction to advanced paint protection, we help keep your vehicle looking its best.'),
('phone', '081303 29288'),
('phone_display', '081303 29288'),
('whatsapp_number', '918130329288'),
('address', 'K-6, New Mahavir Nagar, Tilak Nagar, New Delhi, Delhi 110018'),
('email', 'info@thetorquestudio.in'),
('google_maps_url', 'https://maps.google.com/?q=The+Torque+Studio+Tilak+Nagar+New+Delhi'),
('google_business_url', 'https://maps.google.com/?q=The+Torque+Studio+K-6+New+Mahavir+Nagar+Tilak+Nagar+New+Delhi'),
('business_hours', 'Monday - Sunday: 9:30 AM – 8:00 PM (Prior appointment recommended)'),
('instagram_url', 'https://instagram.com/thetorquestudio'),
('facebook_url', 'https://facebook.com/thetorquestudio'),
('seo_meta_title', 'The Torque Studio | Premium Automotive Detailing in Tilak Nagar, New Delhi'),
('seo_meta_description', 'Leading car detailing, ceramic coating, paint protection film (PPF), and interior cleaning studio in Tilak Nagar, West Delhi. Book an appointment today.');

-- ----------------------------------------------------------
-- 4. Insert FAQs (9 specified essential questions)
-- ----------------------------------------------------------
INSERT INTO `faqs` (`question`, `answer`, `category`, `sort_order`) VALUES
('What is included in car detailing?', 'Car detailing is a comprehensive top-to-bottom restoration of your vehicle. It includes multi-stage exterior decontamination washing, wheel barrel cleaning, mechanical clay bar treatment, machine paint correction to eliminate swirls, and specialized interior rejuvenation (steam sanitization, leather conditioning, upholstery extraction, and vent detailing).', 'General', 1),
('What is the difference between polishing and waxing?', 'Polishing is a corrective process that uses micro-abrasives to level clear coat imperfections, remove swirl marks, and restore gloss. Waxing is a protective layer applied after polishing that seals the surface with carnauba or synthetic polymers, providing hydrophobic water beading and UV shielding for 2 to 3 months.', 'Paint Correction', 2),
('What is ceramic coating?', 'Ceramic coating is a liquid polymer incorporating silicon dioxide (SiO2) that molecularly bonds to your vehicle clear coat. Once cured, it forms a permanent or semi-permanent hydrophobic glass layer that resists UV fading, environmental fallout, bird lime etching, and provides deep reflective gloss.', 'Paint Protection', 3),
('What is graphene coating?', 'Graphene coating uses reduced graphene oxide arranged in a honeycomb carbon lattice. It delivers all the benefits of ceramic coating while offering significantly lower surface heat absorption, which helps prevent stubborn mineral water spotting under Delhi sun, alongside incredible surface slickness.', 'Paint Protection', 4),
('What is PPF (Paint Protection Film)?', 'Paint Protection Film is an optically clear, self-healing aliphatic polyurethane film applied over exterior painted panels. Unlike coatings which protect chemically, PPF provides physical impact resistance against flying rock chips, road gravel, parking scratches, and vandalism.', 'Paint Protection', 5),
('Do you provide interior cleaning?', 'Yes! We provide complete interior cleaning, deep upholstery extraction, leather cleansing and conditioning, roof headliner dry cleaning, and anti-static dashboard protection using pH-neutral, non-greasy products.', 'Interior Detailing', 6),
('Is pick-up and drop-off available?', 'Yes, we provide convenient vehicle pick-up and drop-off services across Tilak Nagar, Janakpuri, Rajouri Garden, and West Delhi. Our drivers follow strict condition checks and install protective covers during transit.', 'Services & Convenience', 7),
('How do I book a service?', 'You can book an appointment enquiry directly through our website booking form, call our studio at 081303 29288, or reach us via WhatsApp. Our team will verify your vehicle requirements and confirm studio slot availability.', 'Booking & Appointments', 8),
('Where is The Torque Studio located?', 'The Torque Studio is conveniently located at K-6, New Mahavir Nagar, Tilak Nagar, New Delhi, Delhi 110018. We are easily accessible from Outer Ring Road, Najafgarh Road, and major West Delhi routes.', 'Location', 9);

-- ----------------------------------------------------------
-- 5. Insert Gallery Items (Showcase & Before/After)
-- ----------------------------------------------------------
INSERT INTO `gallery_items` (`title`, `category`, `before_image`, `after_image`, `description`, `vehicle_type`, `is_before_after`, `sort_order`) VALUES
('Porsche 911 GT3 Paint Correction & PPF', 'Paint Protection', '/assets/gallery/before-swirls.jpg', '/assets/gallery/porsche-after.jpg', 'Full multi-stage paint correction followed by high-gloss self-healing PPF wrap.', 'Porsche 911 GT3', 1, 1),
('Mercedes-AMG G63 Ceramic Coating', 'Ceramic Coating', '/assets/gallery/before-dull-black.jpg', '/assets/gallery/g63-after.jpg', 'Deep 9H ceramic coating application on Obsidian Black Metallic paint.', 'Mercedes-AMG G63', 1, 2),
('BMW M4 Competition Multi-Stage Polishing', 'Paint Correction', '/assets/gallery/before-swirls-m4.jpg', '/assets/gallery/bmw-m4-after.jpg', 'Swirl mark and scratch elimination with finishing jeweling polish.', 'BMW M4 Competition', 1, 3),
('Audi RS5 Graphene Matrix Protection', 'Ceramic Coating', NULL, '/assets/gallery/audi-rs5.jpg', 'Ultra-slick graphene coating application with IR lamp curing.', 'Audi RS5 Sportback', 0, 4),
('Luxury Cabin Leather Rejuvenation', 'Interior Detailing', '/assets/gallery/before-leather.jpg', '/assets/gallery/after-leather.jpg', 'Sebum removal, deep cleansing, and matte OEM leather nourishment.', 'Range Rover Autobiography', 1, 5),
('Photochromic Headlight Protection Film', 'Paint Protection', NULL, '/assets/gallery/photochromic-demo.jpg', 'Smart UV light-reactive photochromic protection film on matrix LED lenses.', 'BMW M8 Gran Coupe', 0, 6);

-- ----------------------------------------------------------
-- 6. Insert Default Admin User
-- Username: admin
-- Password hash: password_hash('Torque@2026Studio!', PASSWORD_BCRYPT)
-- Note: Can also be initialized via interactive first-admin setup
-- ----------------------------------------------------------
INSERT INTO `admins` (`id`, `username`, `email`, `password_hash`) VALUES
(1, 'admin', 'admin@thetorquestudio.in', '$2y$10$JjaMIVwaDGVn.2BLhRDCmu8IKgr.9MBvJkyzAnIbfZZ8vVGjMI7NS');
