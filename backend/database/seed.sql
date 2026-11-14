-- ==========================================================
-- Radiant Detailing Studio — Database Seed Data
-- ==========================================================

USE `radiant_detailing_studio`;

-- ----------------------------------------------------------
-- 1. Insert Service Categories
-- ----------------------------------------------------------
INSERT INTO `service_categories` (`id`, `name`, `slug`, `description`, `sort_order`) VALUES
(1, 'Paint Protection', 'paint-protection', 'Advanced nanotech coatings and self-healing films designed to protect your vehicle paint from environmental hazards, UV rays, and road debris.', 1),
(2, 'Paint Correction', 'paint-correction', 'Precision machine compounding and polishing to eliminate micro-scratches, swirl marks, and restore optical clarity.', 2),
(3, 'Exterior Cleaning', 'exterior-cleaning', 'Touch-safe decontamination, pH-neutral snow foam washing, and detailed exterior rejuvenation.', 3),
(4, 'Window Care & Sun Protection', 'window-care', 'High-performance automotive solar sun films providing heat rejection, glare control, and UV defense.', 4);

-- ----------------------------------------------------------
-- 2. Insert Core Services
-- ----------------------------------------------------------
INSERT INTO `services` (
    `id`, `category_id`, `name`, `slug`, `short_description`, `full_description`,
    `benefits`, `process`, `included_tasks`, `suitable_vehicles`,
    `featured_image`, `gallery_images`, `faqs`, `related_service_ids`,
    `meta_title`, `meta_description`, `canonical_url`,
    `is_featured`, `is_published`, `sort_order`
) VALUES
-- 1. Paint Protection Film (PPF)
(
    1, 1, 'Paint Protection Film (PPF)', 'paint-protection-film-ppf',
    'High-grade self-healing impact polyurethane film safeguarding paint against stone chips, scratches, and road debris.',
    'Paint Protection Film (PPF) is an elastomeric optical barrier engineered to absorb physical impacts from flying gravel, stone chips, and parking scratches. The top layer features advanced thermal self-healing capabilities, allowing light swirl marks to dissipate under warmth and sunlight while preserving your vehicle factory paint finish.',
    '["Stops physical stone chips and road debris damage", "Thermal self-healing top coat removes light swirl marks", "Preserves original factory OEM paint value", "Hydrophobic stain and chemical resistance"]',
    '["Comprehensive exterior decontamination and clay bar prep", "Panel-by-panel paint inspection and light refinement", "Precision pattern templating for exact vehicle fit", "Slip-solution wet installation with wrapped edges", "Thermal edge bonding and final studio inspection"]',
    '["Surface decontamination", "Precision pattern fit", "Edge-wrapped installation", "Thermal cure inspection"]',
    '["Sports Cars", "Luxury Sedans", "Premium SUVs", "All Vehicles"]',
    '/assets/services/ppf.jpg',
    '["/assets/services/ppf.jpg"]',
    '[{"q": "How does self-healing PPF work?", "a": "The elastomeric polyurethane top layer has thermal memory. Warm water or sunlight causes micro-swirls to re-align and disappear."}]',
    '[2, 3, 5]',
    'Paint Protection Film (PPF) | Radiant Detailing Studio',
    'Defend your car with self-healing Paint Protection Film at Radiant Detailing Studio in Kharghar and Vashi.',
    '/services/paint-protection-film-ppf',
    1, 1, 1
),

-- 2. Ceramic Coating
(
    2, 1, 'Ceramic Coating', 'ceramic-coating',
    'Liquid nanotech coating that chemically bonds to clear coat, providing deep optical gloss, extreme water beading, and UV protection.',
    'Ceramic coating utilizes high-purity silicon dioxide (SiO2) that molecularly bonds to vehicle clear coats. Curing to form a semi-permanent hydrophobic shield, it protects against UV oxidation, road film, and bird drop etching while delivering high candy-like optical gloss.',
    '["Deep, reflective optical gloss and color depth", "Hydrophobic self-cleaning effect repels water and grime", "Protects clear coat from harsh UV fading and oxidation", "Significantly reduces vehicle wash maintenance time"]',
    '["Multi-stage touch-safe exterior foam pre-wash", "Mechanical clay bar decontamination", "Machine paint polishing pass to enhance gloss", "Isopropyl alcohol wipe-down for pure surface adhesion", "Even 9H ceramic coating application and cure"]',
    '["Decontamination wash", "Surface refinement", "Ceramic coat application", "Cure inspection"]',
    '["Sedans", "SUVs", "Luxury Vehicles", "Daily Drivers"]',
    '/assets/services/ceramic-coating.jpg',
    '["/assets/services/ceramic-coating.jpg"]',
    '[{"q": "What is the benefit of ceramic coating?", "a": "It provides durable hydrophobic protection, UV defense, and intense gloss that makes routine washing much easier."}]',
    '[1, 3, 5]',
    'Ceramic Coating Services | Radiant Detailing Studio',
    'High-gloss hydrophobic ceramic coating solutions at Radiant Detailing Studio in Kharghar and Vashi.',
    '/services/ceramic-coating',
    1, 1, 2
),

-- 3. Graphene Coating
(
    3, 1, 'Graphene Coating', 'graphene-coating',
    'Advanced carbon honeycomb nanotech coating with reduced thermal heat absorption, combating water spots and delivering extreme slickness.',
    'Graphene coating incorporates reduced graphene oxide matrices that lower paint surface temperatures under intense sunlight. This significantly reduces mineral water spotting compared to traditional coatings while providing exceptional anti-static slickness and rich color saturation.',
    '["Reduced paint surface heat retention", "Actively combats stubborn hard water spot etchings", "Ultra-slick anti-static surface repels dust", "Exceptional chemical and bird dropping resistance"]',
    '["Touch-safe decontaminating pre-wash", "Clay bar treatment across all painted panels", "Paint jeweling polish pass", "Panel prep solvent wipe", "Graphene matrix application and microfiber leveling"]',
    '["Paint prep & decon", "Surface jeweling", "Graphene coating layer", "Leveling buff & inspection"]',
    '["Dark & Black Vehicles", "Luxury SUVs", "Sports Cars", "All Vehicles"]',
    '/assets/services/graphene-coating.jpg',
    '["/assets/services/graphene-coating.jpg"]',
    '[{"q": "How does graphene differ from ceramic?", "a": "Graphene reduces surface heat absorption, which minimizes mineral water spotting, especially on dark-colored vehicles."}]',
    '[1, 2, 5]',
    'Graphene Coating Services | Radiant Detailing Studio',
    'Advanced heat-reducing graphene nano-coating at Radiant Detailing Studio, Kharghar & Vashi.',
    '/services/graphene-coating',
    1, 1, 3
),

-- 4. Sun Films
(
    4, 4, 'Sun Films', 'sun-films',
    'Premium solar control films designed to reject infrared heat, block harmful UV rays, and maintain cabin comfort and privacy.',
    'Automotive sun films offer effective heat rejection and UV defense for your car interior. By blocking up to 99% of damaging ultraviolet rays and significantly reducing infrared solar heat transfer, sun films keep your cabin cooler, reduce air conditioning strain, and protect leather upholstery from premature drying and fading.',
    '["High rejection of solar heat and infrared rays", "Blocks 99% of damaging ultraviolet (UV) radiation", "Protects dashboard and leather upholstery from cracking", "Reduces glare for improved daytime driving comfort"]',
    '["Detailed interior glass surface cleaning and razor scrape", "Computerized or hand-trimmed precision film shaping", "Heat shrinking on exterior glass surface for contour fit", "Dust-controlled wet slip installation on interior glass", "Squeegee moisture extraction and perimeter seal check"]',
    '["Glass decontamination", "Heat contour shaping", "Dust-controlled installation", "Optical clarity check"]',
    '["Hatchbacks", "Sedans", "SUVs", "All Vehicles"]',
    '/assets/services/photochromic-film.jpg',
    '["/assets/services/photochromic-film.jpg"]',
    '[{"q": "Why install automotive sun films?", "a": "Sun films significantly reduce interior cabin heat, block UV rays, reduce glare, and protect interior upholstery from sun damage."}]',
    '[1, 2, 6]',
    'Automotive Sun Films | Radiant Detailing Studio',
    'Premium solar heat rejection and UV protective sun films at Radiant Detailing Studio.',
    '/services/sun-films',
    1, 1, 4
),

-- 5. Car Polishing
(
    5, 2, 'Car Polishing', 'car-polishing',
    'Professional dual-action machine polishing to eliminate light hazing, swirl marks, and restore mirror-like clarity and paint depth.',
    'Over time, routine driving and improper washing cause clear coats to develop fine swirl marks, light scratches, and oxidation that scatter light. Our machine polishing process uses precision dual-action polishers with micro-abrasive refining compounds to safely level minor clear coat defects and reveal true optical clarity and mirror reflections.',
    '["Safely removes wash swirls, micro-scratches, and oxidation", "Restores mirror-like paint depth, gloss, and optical clarity", "Safe clear-coat preserving compounding methods", "Ideal surface preparation before applying coatings or films"]',
    '["Decontaminating hand wash and iron fallout removal", "Mechanical clay bar treatment to lift embedded grit", "Paint depth gauge readings across panels", "Dual-action machine polishing pass with finishing compound", "Residue wipe-down under high-CRI inspection lights"]',
    '["Foam wash & clay prep", "Panel tape masking", "Dual-action polish pass", "Gloss inspection wipe"]',
    '["Show Cars", "Sedans", "SUVs", "All Vehicles"]',
    '/assets/services/car-polishing.jpg',
    '["/assets/services/car-polishing.jpg"]',
    '[{"q": "Does polishing remove scratches?", "a": "Yes, polishing removes light clear-coat scratches, wash swirls, and oxidation to restore full surface gloss."}]',
    '[1, 2, 3]',
    'Professional Car Polishing | Radiant Detailing Studio',
    'Machine car polishing and swirl correction at Radiant Detailing Studio in Kharghar and Vashi.',
    '/services/car-polishing',
    1, 1, 5
),

-- 6. Professional Car Wash
(
    6, 3, 'Professional Car Wash', 'professional-car-wash',
    'Thorough touch-safe two-bucket wash and pH-neutral foam bath targeting wheel wells, door jambs, and exterior road films.',
    'Our professional car wash uses multi-stage touch-safe techniques designed to clean vehicles without inflicting paint swirls. Utilizing calibrated water pressure, pH-neutral snow foam dwell times, two-bucket methods with grit guards, and dedicated wheel cleaning tools, we safely remove road grit, brake dust, and traffic film.',
    '["Touch-safe method prevents wash swirls and scratches", "Thick snow foam breaks down oily road residues safely", "Dedicated wheel barrel and brake dust decontamination", "Plush microfiber towel and blow dry for spot-free finish"]',
    '["Touchless pre-rinse to blast away loose grit and dirt", "Heavy pH-neutral snow foam bath covering vehicle", "Wheel face, barrel, and tyre degreasing with specialized brushes", "Two-bucket hand wash with plush microfiber mitts", "Filtered spot-free rinse and forced-air drying"]',
    '["Pre-rinse rinse", "Snow foam soak", "Two-bucket mitt wash", "Wheel decontamination", "Blow dry"]',
    '["Hatchbacks", "Sedans", "Compact SUVs", "Full-Size 4x4s"]',
    '/assets/services/car-washing.jpg',
    '["/assets/services/car-washing.jpg"]',
    '[{"q": "What makes a professional car wash better than standard washes?", "a": "We use pH-neutral snow foams, grit guards, clean microfiber mitts, and blow-drying to prevent scratches and swirl marks."}]',
    '[1, 4, 5]',
    'Professional Car Wash | Radiant Detailing Studio',
    'Touch-safe pH-neutral professional car washing at Radiant Detailing Studio in Kharghar and Vashi.',
    '/services/professional-car-wash',
    1, 1, 6
);

-- ----------------------------------------------------------
-- 3. Insert Site Settings
-- ----------------------------------------------------------
INSERT INTO `site_settings` (`setting_key`, `setting_value`) VALUES
('site_name', 'Radiant Detailing Studio'),
('tagline', 'Give Your Car the Protection & Shine It Deserves.'),
('supporting_headline', 'Protect Your Paint. Elevate Your Drive.'),
('hero_eyebrow', 'PREMIUM AUTOMOTIVE DETAILING · KHARGHAR & VASHI'),
('hero_title', 'Give Your Car the Protection & Shine It Deserves.'),
('hero_description', 'Experience premium automotive detailing with advanced paint protection, ceramic and graphene coatings, sun films and professional car care solutions at Radiant Detailing Studio.'),
('phone_kharghar', '+91 8591948464'),
('phone_vashi', '+91 7021003015'),
('whatsapp_kharghar', '918591948464'),
('whatsapp_vashi', '917021003015'),
('instagram_url', 'https://www.instagram.com/radiantdetailingstudio/?hl=en'),
('seo_meta_title', 'Radiant Detailing Studio | PPF, Ceramic Coating & Car Detailing'),
('seo_meta_description', 'Discover Radiant Detailing Studio for PPF, ceramic coating, graphene coating, sun films, car polishing and professional car care in Kharghar and Vashi.');

-- ----------------------------------------------------------
-- 4. Insert FAQs
-- ----------------------------------------------------------
INSERT INTO `faqs` (`question`, `answer`, `category`, `sort_order`) VALUES
('What services are offered at Radiant Detailing Studio?', 'Radiant Detailing Studio provides comprehensive automotive detailing solutions including Paint Protection Film (PPF), Ceramic Coating, Graphene Coating, Sun Films, Car Polishing, and Professional Car Washing.', 'General', 1),
('What is the difference between PPF and Ceramic Coating?', 'Paint Protection Film (PPF) is an elastomeric optical barrier designed to absorb physical impacts from flying gravel, stone chips, and scratches. Ceramic coating is a liquid nanotech polymer that molecularly bonds to your clear coat to deliver extreme gloss, UV protection, and hydrophobic self-cleaning properties.', 'Paint Protection', 2),
('What is Graphene Coating?', 'Graphene coating utilizes carbon honeycomb nanotechnology to reduce surface heat retention on exterior panels, minimizing mineral water spotting while providing superior slickness, gloss, and chemical resistance.', 'Paint Protection', 3),
('Why are Sun Films beneficial for vehicles?', 'Automotive sun films reject solar heat, block up to 99% of harmful UV rays, and reduce interior glare, protecting cabin upholstery from premature fading and keeping the vehicle interior cooler.', 'Window Care', 4),
('How do I book a service or get a quotation?', 'You can book an appointment enquiry through our website booking form, contact our Kharghar team at +91 8591948464, contact our Vashi team at +91 7021003015, or reach out to us via WhatsApp and Instagram @radiantdetailingstudio.', 'Booking', 5),
('Where are your contact locations?', 'We serve customers through our dedicated contact options for Kharghar (+91 8591948464) and Vashi (+91 7021003015). Prior consultation or appointment is recommended.', 'Location', 6);

-- ----------------------------------------------------------
-- 5. Insert Gallery Items
-- ----------------------------------------------------------
INSERT INTO `gallery_items` (`title`, `category`, `before_image`, `after_image`, `description`, `vehicle_type`, `is_before_after`, `sort_order`) VALUES
('Paint Correction & Self-Healing PPF Wrap', 'Paint Protection', '/assets/gallery/before-swirls.jpg', '/assets/gallery/porsche-after.jpg', 'Multi-stage paint correction followed by high-gloss self-healing PPF wrap.', 'Sports Coupe', 1, 1),
('Deep Ceramic Coating Application', 'Ceramic Coating', '/assets/gallery/before-dull-black.jpg', '/assets/gallery/g63-after.jpg', 'Deep 9H ceramic coating application with mirror gloss and hydrophobic finish.', 'Luxury SUV', 1, 2),
('Multi-Stage Machine Polishing & Jeweling', 'Paint Correction', '/assets/gallery/before-swirls-m4.jpg', '/assets/gallery/bmw-m4-after.jpg', 'Swirl mark elimination with micro-finishing jeweling polish.', 'Performance Sedan', 1, 3),
('Graphene Matrix Paint Protection', 'Ceramic Coating', NULL, '/assets/gallery/audi-rs5.jpg', 'Ultra-slick graphene coating application with high water beading contact angle.', 'Sportback', 0, 4),
('Interior Deep Cleaning & Cabin Rejuvenation', 'Interior Detailing', '/assets/gallery/before-leather.jpg', '/assets/gallery/after-leather.jpg', 'Deep cleansing and matte OEM leather nourishment.', 'Executive SUV', 1, 5),
('Automotive Sun Film & Lens Protection', 'Paint Protection', NULL, '/assets/gallery/photochromic-demo.jpg', 'High-performance solar control film and lens protective wrap.', 'Luxury Sedan', 0, 6);

-- ----------------------------------------------------------
-- 6. Insert Default Admin User
-- ----------------------------------------------------------
INSERT INTO `admins` (`id`, `username`, `email`, `password_hash`) VALUES
(1, 'admin', 'admin@radiantdetailing.local', '$2y$10$JjaMIVwaDGVn.2BLhRDCmu8IKgr.9MBvJkyzAnIbfZZ8vVGjMI7NS');
