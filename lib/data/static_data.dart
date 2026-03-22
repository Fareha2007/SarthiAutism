import 'package:sarthi_flutter_project/models/models.dart';
import 'package:sarthi_flutter_project/models/app_model.dart';

// ── GOVERNMENT SCHEMES ────────────────────────────────────────────────────────
const List<GovtScheme> kSchemes = [
  GovtScheme(
    id: 'udid',
    name: 'UDID Card',
    ministry: 'DEPwD, Govt. of India',
    eligibility: 'Any person with a certified disability',
    description:
        'Unique Disability ID card that serves as a single document of identity and disability certificate across India. Required to access most disability benefits.',
    icon: '🪪',
    category: 'Identity',
    helplineNumber: '1800-11-4515',
    applyUrl: 'https://www.swavlambancard.gov.in',
  ),
  GovtScheme(
    id: 'adip',
    name: 'ADIP Scheme',
    ministry: 'Ministry of SJ&E',
    eligibility: 'Income below ₹20,000/month with certified disability',
    description:
        'Assistance to Disabled Persons for Purchase/Fitting of Aids & Appliances. Provides financial aid to buy assistive devices like hearing aids, wheelchairs, and AAC devices.',
    icon: '🦽',
    category: 'Financial',
    helplineNumber: '1800-11-4515',
    applyUrl: 'https://alimco.in',
  ),
  GovtScheme(
    id: 'rbsk',
    name: 'RBSK — Rashtriya Bal Swasthya Karyakram',
    ministry: 'Ministry of Health & Family Welfare',
    eligibility: 'Children aged 0–18 years',
    description:
        'Free screening and early intervention for children with developmental delays including autism. Covers diagnosis, treatment, and referral to DEICs.',
    icon: '👶',
    category: 'Healthcare',
    helplineNumber: '104',
    applyUrl: 'https://rbsk.gov.in',
  ),
  GovtScheme(
    id: 'niramaya',
    name: 'Niramaya Health Insurance',
    ministry: 'National Trust',
    eligibility: 'Persons with autism, CP, MR, or multiple disabilities',
    description:
        'Health insurance up to ₹1 lakh/year. Free for families with annual income below ₹15,000. Covers OPD, hospitalisation, and therapies.',
    icon: '🏥',
    category: 'Healthcare',
    helplineNumber: '1800-11-3377',
    applyUrl: 'https://thenationaltrust.gov.in',
  ),
  GovtScheme(
    id: 'vikaas',
    name: 'VIKAAS — Day Care Programme',
    ministry: 'National Trust',
    eligibility: 'Persons with autism, CP, MR, or multiple disabilities',
    description:
        'Supports registered NGOs to provide day-care and vocational training services to persons with developmental disabilities.',
    icon: '🏫',
    category: 'Education',
    applyUrl: 'https://thenationaltrust.gov.in',
    helplineNumber: '',
  ),
  GovtScheme(
    id: 'national_trust',
    name: 'National Trust Schemes',
    ministry: 'National Trust for Welfare of PwD',
    eligibility: 'Persons with autism, CP, MR, or multiple disabilities',
    description:
        'Umbrella of programmes including SAMARTH (caregivers), GHARAUNDA (group homes), PRERNA (incentives for NGOs), and legal guardianship.',
    icon: '🤝',
    category: 'Financial',
    helplineNumber: '1800-11-3377',
    applyUrl: 'https://thenationaltrust.gov.in',
  ),
  GovtScheme(
    id: 'samagra_shiksha',
    name: 'Samagra Shiksha Abhiyan',
    ministry: 'Ministry of Education',
    eligibility: 'Children with disabilities in government schools',
    description:
        'Inclusive education programme providing free assistive devices, resource teachers, and special training for children with disabilities in mainstream schools.',
    icon: '📚',
    category: 'Education',
    applyUrl: 'https://samagra.education.gov.in',
    helplineNumber: '',
  ),
  GovtScheme(
    id: 'depwd_scholarship',
    name: 'DEPwD Scholarship Schemes',
    ministry: 'Dept. of Empowerment of PwD',
    eligibility: 'Students with disability, income below ₹2.5 lakh/year',
    description:
        'Pre-matric and post-matric scholarships for disabled students studying in government/recognised schools and colleges.',
    icon: '🎓',
    category: 'Education',
    applyUrl: 'https://scholarships.gov.in',
    helplineNumber: '',
  ),
];

//── ARTICLES ──────────────────────────────────────────────────────────────────
// final List<Article> kArticles = [
//   Article(
//     id: 'art_001',
//     title: 'Understanding Your Child\'s Autism Diagnosis',
//     preview: 'Getting a diagnosis can feel overwhelming.',
//     body: '''
// # Understanding Your Child's Autism Diagnosis

// Receiving an autism diagnosis for your child can bring a mix of emotions.

// ## What the Diagnosis Means
// Autism affects communication and sensory processing.

// ## Immediate Next Steps
// 1. Don't panic
// 2. Apply for UDID
// 3. Start early intervention
// 4. Connect with other parents
// ''',
//     icon: '🔍',
//     tag: 'Diagnosis',
//     readTime: '5 min',
//   ),
// ];
final List<Article> kArticles = [
  Article(
    id: 'art_001',
    title: 'Understanding Your Child\'s Autism Diagnosis',
    preview:
        'Getting a diagnosis can feel overwhelming. Here\'s what to do next.',
    icon: '🔍',
    tag: 'Diagnosis',
    readTime: '5 min',
    body: '''
# Understanding Your Child's Autism Diagnosis

Receiving an autism diagnosis for your child can bring a mix of emotions — relief, grief, confusion, and hope all at once. You are not alone.

## What the Diagnosis Means

Autism Spectrum Disorder (ASD) affects how a person communicates, processes sensory input, and interacts with the world. It is a spectrum, meaning every child is different.

## Immediate Next Steps

1. Take a breath — a diagnosis is the beginning of support, not the end of hope
2. Apply for a UDID card to access government benefits
3. Start early intervention therapy as soon as possible
4. Connect with other autism parents in your city
5. Keep a simple diary of your child's strengths and challenges

## What Early Intervention Can Do

Research shows that children who receive therapy before age 5 show significantly better outcomes in communication, social skills, and independence.

## You Are Your Child's Best Advocate

No one knows your child better than you. Trust your instincts, ask questions, and never stop learning.
''',
  ),
  Article(
    id: 'art_002',
    title: 'How to Apply for the UDID Card',
    preview: 'The UDID card unlocks most disability benefits in India.',
    icon: '🪪',
    tag: 'Benefits',
    readTime: '4 min',
    body: '''
# How to Apply for the UDID Card

The Unique Disability ID (UDID) card is the most important document for accessing disability benefits in India. It combines identity proof and disability certificate into one.

## Who Can Apply

Any person with a certified disability under the RPwD Act 2016 can apply, including children with autism.

## Documents Needed

1. Aadhaar card of the child and parent
2. Passport-size photograph
3. Disability certificate from a government hospital
4. Birth certificate of the child

## How to Apply

1. Visit www.swavlambancard.gov.in
2. Click "Apply for UDID"
3. Fill in personal and disability details
4. Upload the required documents
5. Submit and note your application number
6. Visit your district CMO office for verification if required

## After You Receive the Card

- Carry it when visiting government hospitals
- Use it to apply for railway concessions
- Required for Niramaya, ADIP, and scholarship schemes

## Important Note

The process is free of cost. Beware of anyone charging money to help you apply.
''',
  ),
  Article(
    id: 'art_003',
    title: 'Early Signs of Autism in Toddlers',
    preview: 'Knowing the early signs helps you act sooner.',
    icon: '👶',
    tag: 'Early Signs',
    readTime: '5 min',
    body: '''
# Early Signs of Autism in Toddlers

Early identification is the single most powerful factor in improving outcomes for children with autism. Here are signs to watch for.

## Signs Before 12 Months

- Does not respond to their name being called
- Limited or no eye contact
- Does not smile back when you smile at them
- Does not babble or make cooing sounds

## Signs Between 12–24 Months

- No single words by 16 months
- No two-word phrases by 24 months
- Does not point to show interest in things
- Loses language skills they previously had
- Repetitive movements like hand-flapping or rocking

## Signs Between 2–4 Years

- Prefers to play alone rather than with other children
- Takes things very literally
- Difficulty with changes in routine
- Strong, focused interest in specific topics or objects
- Unusual reactions to sounds, textures, or lights

## What To Do If You Notice These Signs

1. Do not wait and watch — early action matters
2. Visit a developmental paediatrician
3. Ask for an M-CHAT screening at your next check-up
4. Contact RBSK through your nearest government health centre

## Remember

Noticing signs early is not about labelling your child. It is about getting them the right support at the right time.
''',
  ),
  Article(
    id: 'art_004',
    title: 'Speech Therapy at Home — Simple Daily Exercises',
    preview:
        'You don\'t need to wait for clinic appointments to support communication.',
    icon: '🗣️',
    tag: 'Therapy',
    readTime: '6 min',
    body: '''
# Speech Therapy at Home — Simple Daily Exercises

Parents are the most important communication partners for their child. These simple exercises can be done every day at home.

## Exercise 1 — Follow Their Lead

Sit with your child and let them choose the activity. Comment on what they are doing without asking questions. This reduces pressure and opens natural communication.

## Exercise 2 — Expand Their Words

When your child says one word, add one more.
- Child says: "Ball"
- You say: "Red ball" or "Throw ball"

## Exercise 3 — Pause and Wait

After asking a question or making a comment, pause for 5–10 seconds. Give your child time to process and respond. Resist the urge to fill the silence.

## Exercise 4 — Narrate Daily Routines

Talk through everything you do together.
- "Now we wash hands. Soap on hands. Rub rub rub. Rinse with water."

## Exercise 5 — Singing and Rhymes

Songs like "Wheels on the Bus" with actions help build vocabulary, memory, and turn-taking. Pause before the last word of a familiar line and let your child fill it in.

## How Much Time Is Needed

Even 15 minutes of focused, joyful interaction daily makes a real difference. Quality matters more than quantity.

## Important Note

These exercises support but do not replace professional speech therapy. Ask your therapist to suggest exercises specific to your child's goals.
''',
  ),
  Article(
    id: 'art_005',
    title: 'Managing Sensory Overload in Public',
    preview:
        'Meltdowns in public places can be stressful. Here\'s how to prepare.',
    icon: '🎧',
    tag: 'Sensory',
    readTime: '5 min',
    body: '''
# Managing Sensory Overload in Public

Many autistic children experience the world more intensely — sounds, lights, crowds, and textures can quickly become overwhelming. Planning ahead makes outings much easier.

## What Causes Sensory Overload

- Loud or sudden noises (malls, traffic, crowds)
- Bright or flickering lights
- Strong smells (food courts, perfumes)
- Being touched unexpectedly
- Too much visual information at once

## Signs Your Child Is Getting Overwhelmed

- Covering ears or eyes
- Becoming clingy or trying to leave
- Increased stimming (rocking, flapping)
- Crying, shouting, or shutting down completely

## Preparation Before Going Out

1. Show pictures or videos of the place beforehand
2. Visit at quieter times — early mornings work well
3. Pack a sensory kit: headphones, sunglasses, a favourite fidget toy, snacks
4. Plan an exit strategy and share it with your child

## During the Outing

- Give your child a heads-up before transitions ("5 more minutes, then we leave")
- Identify a quiet corner or exit route when you arrive
- Watch for early warning signs and act before full overload

## After a Meltdown

A meltdown is not bad behaviour — it is a neurological response to overwhelm. Stay calm, reduce stimulation, and offer comfort without too many words.

## Building Tolerance Slowly

Gradual, positive exposure to busy environments — starting small and building up — helps many children expand their comfort zone over time.
''',
  ),
  Article(
    id: 'art_006',
    title: 'Financial Support Available for Autism Families in India',
    preview: 'Several government schemes provide direct financial help.',
    icon: '💰',
    tag: 'Benefits',
    readTime: '5 min',
    body: '''
# Financial Support Available for Autism Families in India

Raising a child with autism involves significant expenses. Several government programmes can reduce this burden substantially.

## 1. ADIP Scheme

Provides assistive devices like AAC devices, hearing aids, and wheelchairs free of cost or at subsidised rates to families earning below ₹20,000 per month.

## 2. Niramaya Health Insurance

Health insurance up to ₹1 lakh per year for persons with autism, cerebral palsy, intellectual disability, or multiple disabilities. Completely free for families with annual income below ₹15,000.

## 3. DEPwD Scholarships

Pre-matric and post-matric scholarships for students with disabilities studying in government or recognised schools and colleges. Income limit: ₹2.5 lakh per year.

## 4. Railway Concessions

- 75% concession on train travel for the person with disability
- 75% concession for one escort travelling with them
- Valid on Sleeper and AC classes with UDID card

## 5. State Government Schemes

Many state governments offer additional support:
- Monthly disability pension (₹500–₹3,000 depending on state)
- Free bus travel on state transport
- Priority in government housing schemes

## How to Access These Benefits

1. Get your UDID card first — it is required for most schemes
2. Visit your District Disability Rehabilitation Centre (DDRC)
3. Ask your district social welfare office about state-specific schemes

## Important Note

Benefits vary by state and income. Always verify current eligibility at the official government portal before applying.
''',
  ),
  Article(
    id: 'art_007',
    title: 'Building a Daily Routine That Works',
    preview: 'Predictable routines reduce anxiety and improve behaviour.',
    icon: '📅',
    tag: 'Parenting',
    readTime: '5 min',
    body: '''
# Building a Daily Routine That Works

Children with autism thrive on predictability. A consistent daily routine reduces anxiety, minimises meltdowns, and helps your child feel safe and in control.

## Why Routine Matters

- Reduces the mental effort of not knowing what comes next
- Builds independence over time
- Makes transitions smoother
- Helps the child participate actively in daily life

## How to Build a Good Routine

1. Keep wake-up, meal, and bedtime at the same time every day
2. Use a visual schedule — pictures work better than words for many children
3. Warn your child before transitions ("In 5 minutes we will have dinner")
4. Start with the most difficult tasks when energy is highest (usually mornings)
5. Build in free time and preferred activities as rewards

## Visual Schedule Tips

- Use real photographs of your child doing each activity
- Place the schedule where your child can see and touch it
- Let the child physically move or flip each item as it is completed
- This gives them control and reduces resistance

## Handling Routine Disruptions

Unexpected changes are unavoidable. Prepare your child by:
- Talking about possible changes in advance when possible
- Having a "surprise" card on the visual schedule
- Practising small, manageable changes regularly so flexibility grows

## Morning and Bedtime Routines

These two are the most important. A calm, predictable bedtime routine dramatically improves sleep, which in turn improves behaviour and learning the next day.
''',
  ),
  Article(
    id: 'art_008',
    title: 'Talking to Your Child\'s School About Autism',
    preview: 'Effective communication with teachers makes a big difference.',
    icon: '🏫',
    tag: 'Education',
    readTime: '4 min',
    body: '''
# Talking to Your Child's School About Autism

Your child spends a large part of their day at school. Building a strong partnership with their teachers is one of the most important things you can do.

## Before the School Year Starts

1. Request a meeting with the class teacher and principal
2. Share your child's diagnosis and a brief summary of their strengths and challenges
3. Bring any therapy reports or assessments
4. Ask about the school's experience with autism and special needs

## What to Ask the School

- Is there a resource room or special educator available?
- Can my child have a quiet space to decompress if overwhelmed?
- How will you communicate with me about daily progress?
- What is the plan if my child has a meltdown?

## Your Child's Rights

Under the RPwD Act 2016 and the Right to Education Act, children with disabilities have the right to:
- Free and appropriate education in mainstream schools
- Reasonable accommodations and modifications
- A barrier-free environment

## Creating an Individual Education Plan (IEP)

Ask the school to create an IEP specific to your child. This document outlines learning goals, accommodations, and support strategies. Review it every term.

## Keeping Communication Open

- Share brief weekly updates with the teacher
- Note anything that affected your child that morning (poor sleep, diet changes)
- Celebrate successes — teachers need positive feedback too

## If the School Is Not Cooperating

Contact your District Education Officer or the State Commissioner for Persons with Disabilities. You have legal backing to demand appropriate support.
''',
  ),
];
// ── DISABILITY BENEFITS ───────────────────────────────────────────────────────
const List<DisabilityBenefit> kBenefits = [
  DisabilityBenefit(
    title: 'Indian Railways — 75% Concession',
    category: 'Travel',
    description:
        'Persons with autism and their escort get 75% off on Sleeper/AC classes with UDID.',
    actReference: 'RPwD Act 2016, Railway Concession Rules',
    learnMoreUrl: 'https://indianrailways.gov.in/concessions',
    icon: '🚆',
  ),
  DisabilityBenefit(
    title: 'State Road Transport Concessions',
    category: 'Travel',
    description: 'Free or discounted bus travel for persons with disabilities.',
    actReference: 'State-specific Motor Vehicle Acts',
    learnMoreUrl: 'https://disabilityaffairs.gov.in',
    icon: '🚌',
  ),
  // Add other benefits...
];

// ── CAREER OPTIONS ───────────────────────────────────────────────────────────
final List<CareerOption> kCareers = [
  CareerOption(
    title: 'Software Testing & QA',
    description:
        'Attention to detail and pattern recognition make autistic individuals excellent at finding bugs.',
    icon: '💻',
    salaryRange: '₹3–12 LPA',
    skillTags: const ['Detail-oriented', 'Logical', 'Pattern recognition'],
    isForChild: true,
  ),
  CareerOption(
    title: 'Data Entry & Analysis',
    description:
        'High accuracy, focus, and consistency are prized in data roles.',
    icon: '📊',
    salaryRange: '₹2–8 LPA',
    skillTags: ['Accuracy', 'Focus', 'Consistency'],
    isForChild: true,
  ),
  // Add other career options...
];

// ── M-CHAT QUESTIONS ─────────────────────────────────────────────────────────
const List<String> kMCHAT = [
  "If you point at something across the room, does your child look at it?",
  "Have you ever wondered if your child might be deaf?",
  "Does your child play pretend or make-believe?",
  // Add all remaining questions...
];

// ── ACTIVITIES ───────────────────────────────────────────────────────────────
// const List<Activity> kActivities = [
//   Activity(
//     id: 1,
//     title: "Name That Object",
//     category: "communication",
//     icon: "💬",
//     duration: "10 min",
//     ageGroups: ["2-4", "5-8"],
//     supportLevels: ["mild", "moderate"],
//     source: "CDC Learn the Signs",
//     instructions:
//         "Point to 5 household objects. Wait for child to repeat. Celebrate attempts.",
//   ),
//   Activity(
//     id: 2,
//     title: "Echo Songs",
//     category: "communication",
//     icon: "🎵",
//     duration: "10 min",
//     ageGroups: ["2-4", "5-8"],
//     supportLevels: ["mild", "moderate", "high"],
//     source: "ESDM Parent Guide",
//     instructions: "Sing nursery rhymes; pause for child to fill in.",
//   ),
//   // Add remaining activities...
// ];
const List<Activity> kActivities = [
  // ── COMMUNICATION ──────────────────────────────────────────────────────────
  Activity(
    id: 1,
    title: 'Name That Object',
    category: 'communication',
    icon: '💬',
    duration: '10 min',
    ageGroups: ['2-4', '5-8'],
    supportLevels: ['mild', 'moderate'],
    source: 'CDC Learn the Signs',
    instructions:
        'Point to 5 household objects one by one. Say the name clearly. Wait 5 seconds for child to repeat or gesture. Celebrate every attempt with clapping or a smile.',
  ),
  Activity(
    id: 2,
    title: 'Echo Songs',
    category: 'communication',
    icon: '🎵',
    duration: '10 min',
    ageGroups: ['2-4', '5-8'],
    supportLevels: ['mild', 'moderate', 'high'],
    source: 'ESDM Parent Guide',
    instructions:
        'Sing a familiar nursery rhyme like "Twinkle Twinkle". Pause just before the last word of each line and wait. Give the child 5 seconds to fill in the word. Repeat 3 times.',
  ),
  Activity(
    id: 3,
    title: 'My Feelings Book',
    category: 'communication',
    icon: '📖',
    duration: '15 min',
    ageGroups: ['3-6', '5-8'],
    supportLevels: ['mild', 'moderate'],
    source: 'PECS Communication Framework',
    instructions:
        'Cut out or draw 6 faces showing happy, sad, angry, scared, surprised, and tired. Paste them in a small notebook. Each day, ask the child to point to how they feel. Name the emotion aloud together.',
  ),
  Activity(
    id: 4,
    title: 'Ask and Answer',
    category: 'communication',
    icon: '🗣️',
    duration: '10 min',
    ageGroups: ['5-8', '9-12'],
    supportLevels: ['mild', 'moderate'],
    source: 'Hanen More Than Words',
    instructions:
        'Take turns asking simple questions: "What is your favourite colour?", "What did you eat today?". Wait for child to answer. If no response after 8 seconds, give two choices: "Red or blue?".',
  ),
  Activity(
    id: 5,
    title: 'Picture Exchange (PECS)',
    category: 'communication',
    icon: '🖼️',
    duration: '10 min',
    ageGroups: ['2-4', '3-6'],
    supportLevels: ['moderate', 'high'],
    source: 'PECS Manual – Pyramid Educational Consultants',
    instructions:
        'Place 3 picture cards of items the child likes (biscuit, ball, juice). When child reaches for something, hold the picture card out. Wait for child to hand you the card before giving the item. Praise immediately.',
  ),
  Activity(
    id: 6,
    title: 'Story Sequencing',
    category: 'communication',
    icon: '📋',
    duration: '15 min',
    ageGroups: ['5-8', '9-12'],
    supportLevels: ['mild', 'moderate'],
    source: 'TEACCH Structured Teaching',
    instructions:
        'Draw or print 4 pictures of a simple daily event (wake up, brush teeth, eat breakfast, go to school). Shuffle them. Ask the child to arrange them in the correct order. Talk through each step together.',
  ),
  Activity(
    id: 7,
    title: 'Greetings Practice',
    category: 'communication',
    icon: '👋',
    duration: '5 min',
    ageGroups: ['2-4', '3-6', '5-8'],
    supportLevels: ['mild', 'moderate', 'high'],
    source: 'ABA Social Skills Curriculum',
    instructions:
        'Stand at the door. Knock and say "Hello!". Encourage child to say "Hello" or wave back. Practise with different greetings: "Good morning", "Bye bye", "See you later". Use a puppet if child is shy.',
  ),

  // ── SENSORY ────────────────────────────────────────────────────────────────
  Activity(
    id: 8,
    title: 'Sensory Bin Exploration',
    category: 'sensory',
    icon: '🪣',
    duration: '15 min',
    ageGroups: ['2-4', '3-6'],
    supportLevels: ['mild', 'moderate', 'high'],
    source: 'OT Sensory Integration Approach',
    instructions:
        'Fill a container with dry rice, lentils, or sand. Hide 5 small toys inside. Let the child dig and find them freely. Name each texture: "rough", "smooth", "bumpy". Never force hands in.',
  ),
  Activity(
    id: 9,
    title: 'Heavy Work Circuit',
    category: 'sensory',
    icon: '🏋️',
    duration: '10 min',
    ageGroups: ['3-6', '5-8'],
    supportLevels: ['moderate', 'high'],
    source: 'Sensory Processing Disorder Foundation',
    instructions:
        'Create a 3-station circuit: (1) Push a filled laundry basket across the room, (2) Carry a backpack with 2 books for 1 minute, (3) Do 10 wall push-ups. Heavy work calms the nervous system.',
  ),
  Activity(
    id: 10,
    title: 'Bubble Wrap Stomp',
    category: 'sensory',
    icon: '🫧',
    duration: '5 min',
    ageGroups: ['2-4', '3-6', '5-8'],
    supportLevels: ['mild', 'moderate', 'high'],
    source: 'Sensory Play Therapy',
    instructions:
        'Lay a large sheet of bubble wrap on the floor. Let the child walk, jump, or stomp on it barefoot. The popping sound and foot pressure provide strong sensory feedback. Count the pops together.',
  ),
  Activity(
    id: 11,
    title: 'Playdough Squeeze',
    category: 'sensory',
    icon: '🟡',
    duration: '15 min',
    ageGroups: ['2-4', '3-6', '5-8'],
    supportLevels: ['mild', 'moderate', 'high'],
    source: 'Fine Motor OT Activities',
    instructions:
        'Give child a ball of homemade or store playdough. Show how to squeeze, roll, flatten, and poke. Make simple shapes together — a snake, a ball, a pancake. The pressure calms and builds hand strength.',
  ),
  Activity(
    id: 12,
    title: 'Calm Corner Kit',
    category: 'sensory',
    icon: '🧸',
    duration: '10 min',
    ageGroups: ['3-6', '5-8', '9-12'],
    supportLevels: ['moderate', 'high'],
    source: 'ASD Sensory Regulation Toolkit',
    instructions:
        'Set up a small corner with: a soft blanket, a fidget toy, noise-cancelling headphones, and one favourite object. When child is overwhelmed, guide them gently to this corner. Sit quietly nearby. Do not talk for the first 2 minutes.',
  ),
  Activity(
    id: 13,
    title: 'Texture Walk',
    category: 'sensory',
    icon: '👣',
    duration: '10 min',
    ageGroups: ['2-4', '3-6'],
    supportLevels: ['mild', 'moderate'],
    source: 'Sensory Integration Therapy',
    instructions:
        'Lay 5 different fabric squares on the floor: velvet, sandpaper, cotton, plastic, and foam. Let child walk barefoot across each one. Name each texture. Ask "Do you like this one?" and observe reactions without pressure.',
  ),

  // ── BEHAVIOUR ──────────────────────────────────────────────────────────────
  Activity(
    id: 14,
    title: 'First-Then Board',
    category: 'behaviour',
    icon: '✅',
    duration: '5 min',
    ageGroups: ['2-4', '3-6', '5-8'],
    supportLevels: ['mild', 'moderate', 'high'],
    source: 'ABA Behaviour Support Strategies',
    instructions:
        'Make a simple two-section card: "FIRST" and "THEN". Draw or paste a picture of a task in "FIRST" (e.g. finish vegetables) and a reward in "THEN" (e.g. watch 10 minutes of favourite show). Show child before the task begins.',
  ),
  Activity(
    id: 15,
    title: 'Token Reward Chart',
    category: 'behaviour',
    icon: '⭐',
    duration: '5 min',
    ageGroups: ['3-6', '5-8', '9-12'],
    supportLevels: ['mild', 'moderate'],
    source: 'Applied Behaviour Analysis',
    instructions:
        'Create a chart with 5 empty star spaces. Each time child completes a target behaviour (e.g. sitting for meals, using words), add a star sticker. When all 5 are filled, give a chosen reward. Reset and repeat.',
  ),
  Activity(
    id: 16,
    title: 'Calm Down Thermometer',
    category: 'behaviour',
    icon: '🌡️',
    duration: '10 min',
    ageGroups: ['5-8', '9-12'],
    supportLevels: ['mild', 'moderate'],
    source: 'Zones of Regulation – Leah Kuypers',
    instructions:
        'Draw a large thermometer with 4 zones: Blue (calm), Green (happy/ready), Yellow (worried/silly), Red (angry/out of control). Each day, ask child to colour in where they feel. Talk about what helps move from red to green.',
  ),
  Activity(
    id: 17,
    title: 'Waiting Practice',
    category: 'behaviour',
    icon: '⏳',
    duration: '10 min',
    ageGroups: ['2-4', '3-6', '5-8'],
    supportLevels: ['mild', 'moderate', 'high'],
    source: 'ABA Early Intervention Programme',
    instructions:
        'Hold a preferred item (snack, toy). Show child a visual timer set for 30 seconds. Say "Wait". When timer ends, immediately give the item and say "Great waiting!". Gradually increase wait time by 15 seconds each day.',
  ),
  Activity(
    id: 18,
    title: 'Social Story – Going to the Doctor',
    category: 'behaviour',
    icon: '🏥',
    duration: '10 min',
    ageGroups: ['3-6', '5-8'],
    supportLevels: ['mild', 'moderate', 'high'],
    source: 'Carol Gray Social Stories',
    instructions:
        'Write or print a short 6-panel story: "Today I am going to the doctor. The waiting room has chairs. The doctor will look at my ears and throat. It will feel a little cold. I can hold Mummy\'s hand. After I get a sticker." Read it together 2 days before the appointment.',
  ),
  Activity(
    id: 19,
    title: 'Anger Release Jar',
    category: 'behaviour',
    icon: '🫙',
    duration: '10 min',
    ageGroups: ['5-8', '9-12'],
    supportLevels: ['mild', 'moderate'],
    source: 'CBT for Children with ASD',
    instructions:
        'Fill a clear plastic bottle with water, glitter glue, and a drop of food colouring. Seal tightly. When child is upset, let them shake the jar hard, then watch the glitter slowly settle. Talk about feelings calming down just like the glitter.',
  ),

  // ── ROUTINE ────────────────────────────────────────────────────────────────
  Activity(
    id: 20,
    title: 'Morning Visual Schedule',
    category: 'routine',
    icon: '🌅',
    duration: '15 min',
    ageGroups: ['2-4', '3-6', '5-8'],
    supportLevels: ['mild', 'moderate', 'high'],
    source: 'TEACCH Structured Teaching',
    instructions:
        'Take 6 photographs of your child doing each morning step: wake up, toilet, brush teeth, wash face, get dressed, eat breakfast. Print and laminate them. Stick them in order on the wall at child\'s eye level. Each morning, let child flip each card over when done.',
  ),
  Activity(
    id: 21,
    title: 'Bedtime Wind-Down Routine',
    category: 'routine',
    icon: '🌙',
    duration: '20 min',
    ageGroups: ['2-4', '3-6', '5-8'],
    supportLevels: ['mild', 'moderate', 'high'],
    source: 'Sleep Foundation – Autism Specific',
    instructions:
        'Begin the same 4-step sequence every night at the same time: (1) Warm bath 10 min, (2) Dim lights and change into pyjamas, (3) Read one favourite book together, (4) Say "Sleep time" and leave the room. Consistency over 2 weeks dramatically improves sleep.',
  ),
  Activity(
    id: 22,
    title: 'Transition Warning Practice',
    category: 'routine',
    icon: '🔔',
    duration: '5 min',
    ageGroups: ['2-4', '3-6', '5-8'],
    supportLevels: ['mild', 'moderate', 'high'],
    source: 'ABA Transition Supports',
    instructions:
        'Before every activity change, give a "5 minute warning" using a visual timer or verbal cue. Say: "5 more minutes of playing, then bath time." Then again at 2 minutes. This reduces meltdowns at transitions by giving the brain time to prepare.',
  ),
  Activity(
    id: 23,
    title: 'Chore Chart for Independence',
    category: 'routine',
    icon: '🧹',
    duration: '10 min',
    ageGroups: ['5-8', '9-12'],
    supportLevels: ['mild', 'moderate'],
    source: 'Life Skills ASD Curriculum',
    instructions:
        'Assign 3 simple daily chores appropriate for the child\'s ability: placing dishes in the sink, putting shoes on the rack, or sorting laundry by colour. Use picture labels. Each completed chore gets a tick. Review together at the end of the day and celebrate.',
  ),
  Activity(
    id: 24,
    title: 'Weekend Plan Board',
    category: 'routine',
    icon: '📅',
    duration: '10 min',
    ageGroups: ['5-8', '9-12'],
    supportLevels: ['mild', 'moderate'],
    source: 'Structured Teaching Framework',
    instructions:
        'Every Friday evening, sit together and plan Saturday and Sunday using picture cards or drawings. Include both preferred and non-preferred activities. Let child choose the order of 2 activities. Knowing the plan reduces weekend anxiety significantly.',
  ),
  Activity(
    id: 25,
    title: 'Mealtime Routine Cards',
    category: 'routine',
    icon: '🍽️',
    duration: '10 min',
    ageGroups: ['2-4', '3-6', '5-8'],
    supportLevels: ['mild', 'moderate', 'high'],
    source: 'Feeding Therapy & OT Practice',
    instructions:
        'Create a 5-step mealtime card: (1) Wash hands, (2) Sit at table, (3) Wait for food, (4) Eat with spoon, (5) Say "finished" or show finished card. Place it on the table. Follow the same sequence at every meal. Predictability reduces food refusal.',
  ),
];
// ── DOCTORS ──────────────────────────────────────────────────────────────────
const List<Doctor> kDoctors = [
  Doctor(
      name: "Dr. Sunita Rao",
      role: "Developmental Paediatrician",
      rating: "4.9",
      reviews: "128",
      distance: "2.3 km",
      location: "Koregaon Park, Pune",
      priceRange: "₹800–1200",
      languages: "English, Marathi, Hindi",
      nextAvailable: "Tomorrow, 11 AM",
      image: "👩‍⚕️",
      tags: ["ASD", "ADHD", "Early Intervention"]),
  // Add remaining doctors...
];

// ── THERAPY GAMES ───────────────────────────────────────────────────────────
final List<TherapyGame> kGames = [
  TherapyGame(
    title: "Emotion Cards",
    category: "emotional",
    icon: "😊",
    duration: "10 min",
    objective: "Help children recognize emotions through visual cards.",
    materials: "Emotion flash cards",
    howToPlay: "Show a card and ask the child to identify the emotion.",
    benefit: "Improves emotional recognition and empathy.",
    ageGroups: ["3-6"],
    supportLevels: ["Low", "Moderate"],
  ),
  TherapyGame(
    title: "Follow the Leader",
    category: "motor",
    icon: "🕺",
    duration: "15 min",
    objective: "Improve motor coordination and imitation.",
    materials: "Open space",
    howToPlay: "Parent performs actions and child copies them.",
    benefit: "Enhances motor imitation skills.",
    ageGroups: ["4-8"],
    supportLevels: ["Low", "Moderate"],
  ),
  // Add remaining therapy games...
];

class SpecialistData {
  static const List<String> locationFilters = [
    'All India',
    'Mumbai',
    'Delhi',
    'Bangalore',
    'Pune',
    'Chennai',
    'Hyderabad',
    'Kolkata',
    'Ahmedabad',
    'Jaipur',
    'Aurangabad',
    'Nagpur',
  ];

  static const List<SpecialistDoctor> doctors = [
    SpecialistDoctor(
      id: 'doc_001',
      name: 'Dr. Sheffali Gulati',
      qualification: 'MD Paediatrics, DM Neurology – AIIMS Delhi',
      speciality: 'Paediatric Neurologist',
      hospital: 'AIIMS – All India Institute of Medical Sciences',
      city: 'Delhi',
      state: 'Delhi',
      address: 'Ansari Nagar, New Delhi – 110029',
      phone: '011-26588500',
      fee: '₹500 (Govt OPD)',
      availability: 'Mon–Fri',
      bio:
          'Head of Child Neurology at AIIMS Delhi. Nationally recognised expert in autism, epilepsy, and neurodevelopmental disorders.',
      rating: 4.9,
      reviewCount: 320,
      tags: ['ASD', 'Epilepsy', 'Neurodevelopment', 'ADHD'],
      languages: ['Hindi', 'English'],
      consultationModes: ['In-person'],
      isGovt: true,
      isFree: false,
      offersOnline: false,
      nextSlot: 'Mon, 9 AM',
    ),
    SpecialistDoctor(
      id: 'doc_002',
      name: 'Dr. Vibha Krishnamurthy',
      qualification: 'MD Paediatrics, Fellowship Developmental Paediatrics',
      speciality: 'Developmental Paediatrician',
      hospital: 'Ummeed Child Development Centre',
      city: 'Mumbai',
      state: 'Maharashtra',
      address: 'Bandra East, Mumbai – 400051',
      phone: '022-26590000',
      fee: '₹1,200',
      availability: 'Mon–Sat',
      bio:
          'Founder of Ummeed CDC. Pioneer in early intervention for autism and developmental disabilities in India.',
      rating: 4.9,
      reviewCount: 415,
      tags: ['ASD', 'Early Intervention', 'Developmental Delay'],
      languages: ['English', 'Hindi', 'Marathi'],
      consultationModes: ['In-person', 'Online'],
      isGovt: false,
      isFree: false,
      offersOnline: true,
      nextSlot: 'Wed, 10 AM',
    ),
    SpecialistDoctor(
      id: 'doc_003',
      name: 'Dr. Pratibha Singhi',
      qualification: 'MD, PhD – Paediatric Neurology',
      speciality: 'Paediatric Neurologist',
      hospital: 'Medanta – The Medicity',
      city: 'Gurugram',
      state: 'Haryana',
      address: 'Sector 38, Gurugram – 122001',
      phone: '0124-4141414',
      fee: '₹1,500',
      availability: 'Mon–Sat',
      bio:
          'Former Head of Paediatrics at PGI Chandigarh. Decades of experience in child neurology and autism.',
      rating: 4.8,
      reviewCount: 280,
      tags: ['ASD', 'CP', 'Neurologist', 'Developmental'],
      languages: ['Hindi', 'English'],
      consultationModes: ['In-person', 'Online'],
      isGovt: false,
      isFree: false,
      offersOnline: true,
      nextSlot: 'Tue, 11 AM',
    ),
    SpecialistDoctor(
      id: 'doc_004',
      name: 'Dr. Nandini Mundkur',
      qualification: 'MD Paediatrics, Fellowship Neurodevelopment – USA',
      speciality: 'Developmental Paediatrician',
      hospital: 'Centre for Child Development & Disabilities',
      city: 'Bangalore',
      state: 'Karnataka',
      address: 'Sadashivanagar, Bangalore – 560080',
      phone: '080-23611177',
      fee: '₹1,000',
      availability: 'Mon–Fri',
      bio:
          'Founder of CCDD Bangalore. Specialist in early diagnosis of autism and cerebral palsy.',
      rating: 4.8,
      reviewCount: 198,
      tags: ['ASD', 'CP', 'Early Intervention', 'Developmental Delay'],
      languages: ['English', 'Kannada', 'Hindi'],
      consultationModes: ['In-person'],
      isGovt: false,
      isFree: false,
      offersOnline: false,
      nextSlot: 'Thu, 9 AM',
    ),
    SpecialistDoctor(
      id: 'doc_005',
      name: 'Dr. Samir Dalwai',
      qualification: 'MD Paediatrics, Developmental Paediatrics – Mumbai',
      speciality: 'Developmental Paediatrician',
      hospital: 'Dr. Dalwai\'s Child Development Clinic',
      city: 'Mumbai',
      state: 'Maharashtra',
      address: 'Santacruz West, Mumbai – 400054',
      phone: '+91 98200 12345',
      fee: '₹1,500',
      availability: 'Mon–Sat',
      bio:
          'Leading developmental paediatrician with expertise in ASD, ADHD, and learning disabilities.',
      rating: 4.7,
      reviewCount: 230,
      tags: ['ASD', 'ADHD', 'Learning Disability', 'Behaviour'],
      languages: ['English', 'Hindi', 'Marathi'],
      consultationModes: ['In-person', 'Online'],
      isGovt: false,
      isFree: false,
      offersOnline: true,
      nextSlot: 'Tomorrow, 10 AM',
    ),
    SpecialistDoctor(
      id: 'doc_006',
      name: 'Dr. Ananthakrishnan',
      qualification: 'DM Paediatric Neurology – NIMHANS',
      speciality: 'Paediatric Neurologist',
      hospital: 'NIMHANS',
      city: 'Bangalore',
      state: 'Karnataka',
      address: 'Hosur Road, Bangalore – 560029',
      phone: '080-46110007',
      fee: '₹200 (Govt OPD)',
      availability: 'Mon–Fri',
      bio:
          'Senior consultant at NIMHANS Child & Adolescent Psychiatry. Extensive experience in ASD and neurodevelopmental conditions.',
      rating: 4.8,
      reviewCount: 310,
      tags: ['ASD', 'Child Psychiatry', 'Neurodevelopment'],
      languages: ['English', 'Kannada', 'Tamil'],
      consultationModes: ['In-person'],
      isGovt: true,
      isFree: true,
      offersOnline: false,
      nextSlot: 'Mon, 8 AM',
    ),
    SpecialistDoctor(
      id: 'doc_007',
      name: 'Dr. Ritu Shrivastava',
      qualification: 'MD Psychiatry, DPM – Child Psychiatry',
      speciality: 'Child Psychiatrist',
      hospital: 'KEM Hospital',
      city: 'Mumbai',
      state: 'Maharashtra',
      address: 'Parel, Mumbai – 400012',
      phone: '022-24107000',
      fee: '₹300 (Govt OPD)',
      availability: 'Mon–Sat',
      bio:
          'Child psychiatrist at KEM Hospital with expertise in autism, anxiety, and behavioural disorders.',
      rating: 4.6,
      reviewCount: 175,
      tags: ['ASD', 'Psychiatry', 'Behaviour', 'Anxiety'],
      languages: ['Hindi', 'English', 'Marathi'],
      consultationModes: ['In-person'],
      isGovt: true,
      isFree: false,
      offersOnline: false,
      nextSlot: 'Wed, 9 AM',
    ),
    SpecialistDoctor(
      id: 'doc_008',
      name: 'Dr. Meenakshi Bhat',
      qualification: 'MD Paediatrics, DNB – Developmental Paediatrics',
      speciality: 'Developmental Paediatrician',
      hospital: 'Manipal Hospital',
      city: 'Bangalore',
      state: 'Karnataka',
      address: 'Old Airport Road, Bangalore – 560017',
      phone: '080-25024444',
      fee: '₹1,200',
      availability: 'Mon–Sat',
      bio:
          'Specialist in ASD early diagnosis, ADHD, and learning disabilities with 12 years experience.',
      rating: 4.7,
      reviewCount: 164,
      tags: ['ASD', 'ADHD', 'Developmental', 'Learning Disability'],
      languages: ['English', 'Kannada', 'Hindi'],
      consultationModes: ['In-person', 'Online'],
      isGovt: false,
      isFree: false,
      offersOnline: true,
      nextSlot: 'Fri, 10 AM',
    ),
    SpecialistDoctor(
      id: 'doc_009',
      name: 'Dr. Geeta Fernandez',
      qualification:
          'MD Paediatrics, Cert. Developmental Medicine – CMC Vellore',
      speciality: 'Developmental Paediatrician',
      hospital: 'Christian Medical College',
      city: 'Vellore',
      state: 'Tamil Nadu',
      address: 'Ida Scudder Road, Vellore – 632004',
      phone: '0416-2281000',
      fee: '₹400 (Govt rates)',
      availability: 'Mon–Fri',
      bio:
          'CMC Vellore developmental paediatrician specialising in ASD, global developmental delay, and genetic syndromes.',
      rating: 4.9,
      reviewCount: 260,
      tags: ['ASD', 'Developmental Delay', 'Genetic Syndromes', 'CP'],
      languages: ['English', 'Tamil', 'Hindi'],
      consultationModes: ['In-person'],
      isGovt: true,
      isFree: false,
      offersOnline: false,
      nextSlot: 'Tue, 8 AM',
    ),
    SpecialistDoctor(
      id: 'doc_010',
      name: 'Dr. Sudha Kamath',
      qualification: 'MD Paediatrics, Fellowship Child Neurology',
      speciality: 'Paediatric Neurologist',
      hospital: 'Kokilaben Dhirubhai Ambani Hospital',
      city: 'Mumbai',
      state: 'Maharashtra',
      address: 'Four Bungalows, Andheri West, Mumbai – 400053',
      phone: '022-30999999',
      fee: '₹1,800',
      availability: 'Mon–Sat',
      bio:
          'Paediatric neurologist with expertise in epilepsy, autism, and movement disorders in children.',
      rating: 4.7,
      reviewCount: 188,
      tags: ['ASD', 'Epilepsy', 'Neurology', 'Movement Disorders'],
      languages: ['English', 'Hindi', 'Marathi', 'Kannada'],
      consultationModes: ['In-person', 'Online'],
      isGovt: false,
      isFree: false,
      offersOnline: true,
      nextSlot: 'Thu, 2 PM',
    ),
    SpecialistDoctor(
      id: 'doc_011',
      name: 'Dr. Hemanth Nagappa',
      qualification: 'DM Paediatric Neurology – NIMHANS',
      speciality: 'Paediatric Neurologist',
      hospital: 'Sakra World Hospital',
      city: 'Bangalore',
      state: 'Karnataka',
      address: 'Devarabeesanahalli, Bangalore – 560103',
      phone: '080-49690000',
      fee: '₹1,400',
      availability: 'Mon–Sat',
      bio:
          'Specialist in paediatric epilepsy, autism spectrum disorder, and neuromuscular conditions.',
      rating: 4.8,
      reviewCount: 142,
      tags: ['ASD', 'Epilepsy', 'Neuromuscular', 'ADHD'],
      languages: ['English', 'Kannada', 'Hindi'],
      consultationModes: ['In-person', 'Online'],
      isGovt: false,
      isFree: false,
      offersOnline: true,
      nextSlot: 'Sat, 11 AM',
    ),
    SpecialistDoctor(
      id: 'doc_012',
      name: 'Dr. Jayashree Ramesh',
      qualification: 'MD Psychiatry – NIMHANS, Child & Adolescent Psychiatry',
      speciality: 'Child Psychiatrist',
      hospital: 'Apollo Hospitals',
      city: 'Chennai',
      state: 'Tamil Nadu',
      address: 'Greams Road, Chennai – 600006',
      phone: '044-28290200',
      fee: '₹1,600',
      availability: 'Mon–Fri',
      bio:
          'Child and adolescent psychiatrist specialising in ASD, OCD, anxiety, and school refusal.',
      rating: 4.7,
      reviewCount: 156,
      tags: ['ASD', 'OCD', 'Anxiety', 'School Refusal', 'Psychiatry'],
      languages: ['English', 'Tamil', 'Hindi'],
      consultationModes: ['In-person', 'Online'],
      isGovt: false,
      isFree: false,
      offersOnline: true,
      nextSlot: 'Tue, 3 PM',
    ),
  ];

  static const List<Therapist> therapists = [
    Therapist(
      id: 'th_001',
      name: 'Ms. Ananya Desai',
      qualification: 'M.Sc. Speech-Language Pathology, RCI Registered',
      type: 'Speech Therapist',
      rciNumber: 'RCI/SLP/12345',
      centre: 'Asha Therapy Centre',
      city: 'Pune',
      state: 'Maharashtra',
      phone: '+91 97300 11001',
      fee: '₹600/session',
      rating: 4.7,
      reviewCount: 88,
      sessionTypes: ['Individual', 'Group'],
      ageGroups: ['2–6', '7–12'],
      specialities: ['AAC', 'Verbal Behaviour', 'Social Communication'],
      offersOnline: true,
      offersHome: false,
    ),
    Therapist(
      id: 'th_002',
      name: 'Mr. Suresh Pillai',
      qualification: 'B.Sc. Occupational Therapy, RCI Registered',
      type: 'Occupational Therapist',
      rciNumber: 'RCI/OT/67890',
      centre: 'Rainbow OT Centre',
      city: 'Chennai',
      state: 'Tamil Nadu',
      phone: '+91 94400 22002',
      fee: '₹500/session',
      rating: 4.6,
      reviewCount: 64,
      sessionTypes: ['Individual'],
      ageGroups: ['3–8', '9–14'],
      specialities: ['Sensory Integration', 'Fine Motor', 'ADL'],
      offersOnline: false,
      offersHome: true,
    ),
    Therapist(
      id: 'th_003',
      name: 'Ms. Pooja Mehta',
      qualification: 'M.Sc. Applied Behaviour Analysis, BCBA Certified',
      type: 'ABA Therapist',
      rciNumber: 'BCBA/IN/00234',
      centre: 'Stepping Stones ABA Centre',
      city: 'Mumbai',
      state: 'Maharashtra',
      phone: '+91 98200 33003',
      fee: '₹800/session',
      rating: 4.8,
      reviewCount: 112,
      sessionTypes: ['Individual', 'Home-based'],
      ageGroups: ['2–5', '6–10'],
      specialities: [
        'Early Intensive ABA',
        'Behaviour Reduction',
        'Toilet Training'
      ],
      offersOnline: true,
      offersHome: true,
    ),
    Therapist(
      id: 'th_004',
      name: 'Ms. Rekha Nair',
      qualification: 'M.Sc. Speech-Language Pathology – MAHE, RCI Reg.',
      type: 'Speech Therapist',
      rciNumber: 'RCI/SLP/56789',
      centre: 'Ummeed Child Development Centre',
      city: 'Mumbai',
      state: 'Maharashtra',
      phone: '022-26590000',
      fee: '₹700/session',
      rating: 4.8,
      reviewCount: 134,
      sessionTypes: ['Individual', 'Group', 'Parent Training'],
      ageGroups: ['1–4', '5–10'],
      specialities: ['Early Language', 'AAC', 'Feeding Therapy'],
      offersOnline: true,
      offersHome: false,
    ),
    Therapist(
      id: 'th_005',
      name: 'Mr. Arun Kumar',
      qualification: 'B.Sc. Physiotherapy, Cert. NDT – Bobath',
      type: 'Physiotherapist',
      rciNumber: 'RCI/PT/11223',
      centre: 'NIMHANS Outreach',
      city: 'Bangalore',
      state: 'Karnataka',
      phone: '080-46110007',
      fee: '₹300/session',
      rating: 4.7,
      reviewCount: 96,
      sessionTypes: ['Individual'],
      ageGroups: ['0–3', '4–10'],
      specialities: ['NDT', 'Gross Motor', 'CP Rehabilitation'],
      offersOnline: false,
      offersHome: true,
    ),
    Therapist(
      id: 'th_006',
      name: 'Ms. Deepa Krishnan',
      qualification: 'M.Sc. Special Education (ID & ASD) – RCI Registered',
      type: 'Special Educator',
      rciNumber: 'RCI/SE/44556',
      centre: 'Action for Autism',
      city: 'Delhi',
      state: 'Delhi',
      phone: '011-40540991',
      fee: '₹500/session',
      rating: 4.9,
      reviewCount: 178,
      sessionTypes: ['Individual', 'Group', 'Parent Training'],
      ageGroups: ['3–8', '9–14'],
      specialities: ['Pre-academics', 'Life Skills', 'TEACCH', 'Social Skills'],
      offersOnline: true,
      offersHome: false,
    ),
    Therapist(
      id: 'th_007',
      name: 'Ms. Shruti Joshi',
      qualification: 'M.Sc. Occupational Therapy – SI Certified',
      type: 'Occupational Therapist',
      rciNumber: 'RCI/OT/78901',
      centre: 'CCDD Bangalore',
      city: 'Bangalore',
      state: 'Karnataka',
      phone: '080-23611177',
      fee: '₹650/session',
      rating: 4.7,
      reviewCount: 82,
      sessionTypes: ['Individual'],
      ageGroups: ['2–6', '7–12'],
      specialities: ['Sensory Integration', 'Handwriting', 'School Readiness'],
      offersOnline: false,
      offersHome: false,
    ),
    Therapist(
      id: 'th_008',
      name: 'Mr. Faisal Ahmed',
      qualification: 'M.Phil. Clinical Psychology – RCI Licensed',
      type: 'Behaviour Therapist',
      rciNumber: 'RCI/CP/33445',
      centre: 'Manas Child Guidance Centre',
      city: 'Hyderabad',
      state: 'Telangana',
      phone: '+91 93900 44008',
      fee: '₹600/session',
      rating: 4.6,
      reviewCount: 74,
      sessionTypes: ['Individual', 'Family Therapy'],
      ageGroups: ['4–10', '11–16'],
      specialities: ['CBT', 'Behaviour Reduction', 'Social Skills', 'Anxiety'],
      offersOnline: true,
      offersHome: false,
    ),
    Therapist(
      id: 'th_009',
      name: 'Ms. Kavitha Subramanian',
      qualification: 'M.Sc. Speech-Language Pathology – Mysore University',
      type: 'Speech Therapist',
      rciNumber: 'RCI/SLP/99012',
      centre: 'Vidya Sagar',
      city: 'Chennai',
      state: 'Tamil Nadu',
      phone: '044-24748505',
      fee: '₹400/session',
      rating: 4.8,
      reviewCount: 145,
      sessionTypes: ['Individual', 'Group'],
      ageGroups: ['2–5', '6–12'],
      specialities: ['Augmentative Communication', 'Fluency', 'Voice'],
      offersOnline: true,
      offersHome: false,
    ),
    Therapist(
      id: 'th_010',
      name: 'Ms. Priyanka Shetty',
      qualification: 'BCBA, M.Ed. Special Education',
      type: 'ABA Therapist',
      rciNumber: 'BCBA/IN/00567',
      centre: 'The Catalyst Centre',
      city: 'Bangalore',
      state: 'Karnataka',
      phone: '+91 99000 55010',
      fee: '₹900/session',
      rating: 4.9,
      reviewCount: 103,
      sessionTypes: ['Individual', 'Clinic-based', 'Home-based'],
      ageGroups: ['2–6', '7–12'],
      specialities: [
        'VB-MAPP',
        'Natural Environment Training',
        'Social Skills'
      ],
      offersOnline: true,
      offersHome: true,
    ),
    Therapist(
      id: 'th_011',
      name: 'Mr. Santosh Yadav',
      qualification: 'B.Sc. Physiotherapy, Cert. Sensory Integration',
      type: 'Physiotherapist',
      rciNumber: 'RCI/PT/22334',
      centre: 'Samarpan Rehabilitation Centre',
      city: 'Pune',
      state: 'Maharashtra',
      phone: '+91 96500 66011',
      fee: '₹450/session',
      rating: 4.6,
      reviewCount: 58,
      sessionTypes: ['Individual'],
      ageGroups: ['0–4', '5–12'],
      specialities: ['Gross Motor', 'Balance', 'Sensory Processing'],
      offersOnline: false,
      offersHome: true,
    ),
    Therapist(
      id: 'th_012',
      name: 'Ms. Laleh Irani',
      qualification: 'M.Sc. Special Education, Cert. DIR/Floortime',
      type: 'Special Educator',
      rciNumber: 'RCI/SE/55667',
      centre: 'Expressions Child Development Centre',
      city: 'Mumbai',
      state: 'Maharashtra',
      phone: '+91 98330 77012',
      fee: '₹700/session',
      rating: 4.8,
      reviewCount: 119,
      sessionTypes: ['Individual', 'Parent Coaching'],
      ageGroups: ['1–5', '6–10'],
      specialities: ['DIR/Floortime', 'Play-based Therapy', 'Social Emotional'],
      offersOnline: true,
      offersHome: false,
    ),
  ];

  static const List<SpecialistHospital> hospitals = [
    SpecialistHospital(
      id: 'hosp_001',
      name: 'NIMHANS – National Institute of Mental Health & Neurosciences',
      type: 'Govt',
      address: 'Hosur Road, Bangalore – 560029',
      city: 'Bangalore',
      state: 'Karnataka',
      phone: '080-46110007',
      opdDays: 'Mon–Fri',
      opdTime: '8 AM – 1 PM',
      services: [
        'ASD Diagnosis',
        'Child Psychiatry',
        'Psychology',
        'Speech Therapy',
        'OT'
      ],
      isFree: true,
      isGovt: true,
      hasInpatient: true,
    ),
    SpecialistHospital(
      id: 'hosp_002',
      name: 'Action for Autism',
      type: 'NGO',
      address: 'Lado Sarai, New Delhi – 110030',
      city: 'Delhi',
      state: 'Delhi',
      phone: '011-40540991',
      opdDays: 'Mon–Sat',
      opdTime: '9 AM – 5 PM',
      services: [
        'Diagnosis',
        'ABA Therapy',
        'Parent Training',
        'School Readiness',
        'Advocacy'
      ],
      isFree: false,
      isGovt: false,
      hasInpatient: false,
    ),
    SpecialistHospital(
      id: 'hosp_003',
      name: 'Ummeed Child Development Centre',
      type: 'NGO',
      address: 'Bandra East, Mumbai – 400051',
      city: 'Mumbai',
      state: 'Maharashtra',
      phone: '022-26590000',
      opdDays: 'Mon–Sat',
      opdTime: '9 AM – 6 PM',
      services: [
        'Developmental Paediatrics',
        'Speech Therapy',
        'OT',
        'Psychology',
        'Social Work'
      ],
      isFree: false,
      isGovt: false,
      hasInpatient: false,
    ),
    SpecialistHospital(
      id: 'hosp_004',
      name: 'AIIMS Child Neurology – OPD',
      type: 'Govt',
      address: 'Ansari Nagar, New Delhi – 110029',
      city: 'Delhi',
      state: 'Delhi',
      phone: '011-26588500',
      opdDays: 'Mon–Fri',
      opdTime: '8 AM – 12 PM',
      services: [
        'Neurology OPD',
        'ASD Assessment',
        'EEG',
        'MRI',
        'Genetic Testing'
      ],
      isFree: false,
      isGovt: true,
      hasInpatient: true,
    ),
    SpecialistHospital(
      id: 'hosp_005',
      name: 'Vidya Sagar',
      type: 'NGO',
      address: 'Taramani Road, Chennai – 600113',
      city: 'Chennai',
      state: 'Tamil Nadu',
      phone: '044-24748505',
      opdDays: 'Mon–Sat',
      opdTime: '9 AM – 5 PM',
      services: [
        'Special Education',
        'Speech Therapy',
        'Physiotherapy',
        'Vocational Training'
      ],
      isFree: false,
      isGovt: false,
      hasInpatient: false,
    ),
    SpecialistHospital(
      id: 'hosp_006',
      name: 'Centre for Child Development & Disabilities (CCDD)',
      type: 'Private',
      address: 'Sadashivanagar, Bangalore – 560080',
      city: 'Bangalore',
      state: 'Karnataka',
      phone: '080-23611177',
      opdDays: 'Mon–Sat',
      opdTime: '9 AM – 5 PM',
      services: [
        'Developmental Paediatrics',
        'ASD Clinic',
        'OT',
        'Speech',
        'Physiotherapy'
      ],
      isFree: false,
      isGovt: false,
      hasInpatient: false,
    ),
    SpecialistHospital(
      id: 'hosp_007',
      name: 'KEM Hospital – Child Development Unit',
      type: 'Govt',
      address: 'Parel, Mumbai – 400012',
      city: 'Mumbai',
      state: 'Maharashtra',
      phone: '022-24107000',
      opdDays: 'Mon–Sat',
      opdTime: '8 AM – 12 PM',
      services: [
        'Paediatric OPD',
        'Child Psychiatry',
        'Speech Therapy',
        'Psychology'
      ],
      isFree: false,
      isGovt: true,
      hasInpatient: true,
    ),
    SpecialistHospital(
      id: 'hosp_008',
      name: 'Samarpan Autism & Child Development Centre',
      type: 'Private',
      address: 'Deccan Gymkhana, Pune – 411004',
      city: 'Pune',
      state: 'Maharashtra',
      phone: '+91 96500 88008',
      opdDays: 'Mon–Sat',
      opdTime: '9 AM – 6 PM',
      services: ['ASD Assessment', 'ABA', 'Speech', 'OT', 'Behaviour Therapy'],
      isFree: false,
      isGovt: false,
      hasInpatient: false,
    ),
    SpecialistHospital(
      id: 'hosp_009',
      name: 'The Catalyst Centre',
      type: 'Private',
      address: 'Indiranagar, Bangalore – 560038',
      city: 'Bangalore',
      state: 'Karnataka',
      phone: '+91 99000 99009',
      opdDays: 'Mon–Sat',
      opdTime: '9 AM – 5 PM',
      services: [
        'ABA Therapy',
        'Speech',
        'OT',
        'Social Skills Groups',
        'Parent Training'
      ],
      isFree: false,
      isGovt: false,
      hasInpatient: false,
    ),
    SpecialistHospital(
      id: 'hosp_010',
      name:
          'National Institute for Empowerment of Persons with Intellectual Disabilities (NIEPID)',
      type: 'Govt',
      address: 'Manovikas Nagar, Secunderabad – 500009',
      city: 'Hyderabad',
      state: 'Telangana',
      phone: '040-27751519',
      opdDays: 'Mon–Fri',
      opdTime: '9 AM – 4 PM',
      services: [
        'Assessment',
        'Special Education',
        'Vocational Training',
        'Parent Training'
      ],
      isFree: true,
      isGovt: true,
      hasInpatient: false,
    ),
    SpecialistHospital(
      id: 'hosp_011',
      name: 'Autism Society of Pune',
      type: 'NGO',
      address: 'Kothrud, Pune – 411038',
      city: 'Pune',
      state: 'Maharashtra',
      phone: '+91 98220 11011',
      opdDays: 'Mon–Fri',
      opdTime: '9 AM – 5 PM',
      services: [
        'ASD Support',
        'Parent Groups',
        'ABA',
        'Special Education',
        'Advocacy'
      ],
      isFree: false,
      isGovt: false,
      hasInpatient: false,
    ),
    SpecialistHospital(
      id: 'hosp_012',
      name:
          'NIEPMD – National Institute for Empowerment of PwD (Multiple Disabilities)',
      type: 'Govt',
      address: 'East Coast Road, Chennai – 600119',
      city: 'Chennai',
      state: 'Tamil Nadu',
      phone: '044-24530311',
      opdDays: 'Mon–Fri',
      opdTime: '9 AM – 4 PM',
      services: [
        'Multi-disability Assessment',
        'Therapy',
        'Special Ed',
        'Assistive Devices'
      ],
      isFree: true,
      isGovt: true,
      hasInpatient: false,
    ),
  ];

  static const List<SpecialistSchool> schools = [
    SpecialistSchool(
      id: 'sch_001',
      name: 'Asha Deep Special School',
      type: 'Special',
      board: 'NIOS',
      address: 'Baner Road, Pune – 411045',
      city: 'Pune',
      state: 'Maharashtra',
      phone: '+91 98220 11001',
      ageRange: '4–18 years',
      fees: '₹1,500/month',
      therapiesOnCampus: ['Speech', 'OT', 'Behaviour'],
      isRTE: true,
      isResidential: false,
    ),
    SpecialistSchool(
      id: 'sch_002',
      name: 'Tulip Inclusive School',
      type: 'Inclusive',
      board: 'CBSE',
      address: 'Whitefield, Bangalore – 560066',
      city: 'Bangalore',
      state: 'Karnataka',
      phone: '+91 99800 22002',
      ageRange: '5–16 years',
      fees: '₹4,000/month',
      therapiesOnCampus: ['Speech', 'OT'],
      isRTE: false,
      isResidential: false,
    ),
    SpecialistSchool(
      id: 'sch_003',
      name: 'Vidya Sagar School',
      type: 'Special',
      board: 'NIOS',
      address: 'Taramani Road, Chennai – 600113',
      city: 'Chennai',
      state: 'Tamil Nadu',
      phone: '044-24748505',
      ageRange: '5–20 years',
      fees: '₹800/month',
      therapiesOnCampus: ['Speech', 'Physiotherapy', 'Vocational'],
      isRTE: true,
      isResidential: false,
    ),
    SpecialistSchool(
      id: 'sch_004',
      name: 'Action for Autism – School Programme',
      type: 'Special',
      board: 'NIOS',
      address: 'Lado Sarai, New Delhi – 110030',
      city: 'Delhi',
      state: 'Delhi',
      phone: '011-40540991',
      ageRange: '3–18 years',
      fees: '₹2,500/month',
      therapiesOnCampus: ['ABA', 'Speech', 'OT', 'Social Skills'],
      isRTE: true,
      isResidential: false,
    ),
    SpecialistSchool(
      id: 'sch_005',
      name: 'Manas Foundation School',
      type: 'Inclusive',
      board: 'CBSE',
      address: 'Rohini, New Delhi – 110085',
      city: 'Delhi',
      state: 'Delhi',
      phone: '+91 98110 33005',
      ageRange: '4–14 years',
      fees: '₹3,500/month',
      therapiesOnCampus: ['Speech', 'OT', 'Behaviour'],
      isRTE: false,
      isResidential: false,
    ),
    SpecialistSchool(
      id: 'sch_006',
      name: 'Brindavan Special School',
      type: 'Special',
      board: 'NIOS',
      address: 'JP Nagar, Bangalore – 560078',
      city: 'Bangalore',
      state: 'Karnataka',
      phone: '+91 98440 44006',
      ageRange: '4–18 years',
      fees: '₹1,200/month',
      therapiesOnCampus: ['Speech', 'OT', 'Physiotherapy'],
      isRTE: true,
      isResidential: false,
    ),
    SpecialistSchool(
      id: 'sch_007',
      name: 'Sethu School for Autism',
      type: 'Special',
      board: 'NIOS',
      address: 'Anna Nagar, Chennai – 600040',
      city: 'Chennai',
      state: 'Tamil Nadu',
      phone: '+91 94440 55007',
      ageRange: '3–20 years',
      fees: '₹1,500/month',
      therapiesOnCampus: ['ABA', 'Speech', 'OT', 'Music Therapy'],
      isRTE: true,
      isResidential: true,
    ),
    SpecialistSchool(
      id: 'sch_008',
      name: 'Expressions – The School',
      type: 'Inclusive',
      board: 'ICSE',
      address: 'Bandra West, Mumbai – 400050',
      city: 'Mumbai',
      state: 'Maharashtra',
      phone: '+91 98330 66008',
      ageRange: '3–14 years',
      fees: '₹6,000/month',
      therapiesOnCampus: ['Speech', 'OT', 'Counselling'],
      isRTE: false,
      isResidential: false,
    ),
    SpecialistSchool(
      id: 'sch_009',
      name: 'Disha Centre for Special Needs',
      type: 'Special',
      board: 'NIOS',
      address: 'Satellite, Ahmedabad – 380015',
      city: 'Ahmedabad',
      state: 'Gujarat',
      phone: '+91 97270 77009',
      ageRange: '4–18 years',
      fees: '₹1,000/month',
      therapiesOnCampus: ['Speech', 'OT', 'Behaviour', 'Physiotherapy'],
      isRTE: true,
      isResidential: false,
    ),
    SpecialistSchool(
      id: 'sch_010',
      name: 'NIEPID Training School',
      type: 'Special',
      board: 'NIOS',
      address: 'Manovikas Nagar, Secunderabad – 500009',
      city: 'Hyderabad',
      state: 'Telangana',
      phone: '040-27751519',
      ageRange: '5–18 years',
      fees: 'Free (Govt)',
      therapiesOnCampus: ['Speech', 'OT', 'Physiotherapy', 'Vocational'],
      isRTE: true,
      isResidential: true,
    ),
    SpecialistSchool(
      id: 'sch_011',
      name: 'Ankur School for Special Children',
      type: 'Special',
      board: 'NIOS',
      address: 'Kothrud, Pune – 411038',
      city: 'Pune',
      state: 'Maharashtra',
      phone: '+91 98225 88011',
      ageRange: '4–16 years',
      fees: '₹1,800/month',
      therapiesOnCampus: ['Speech', 'OT', 'ABA', 'Behaviour'],
      isRTE: true,
      isResidential: false,
    ),
    SpecialistSchool(
      id: 'sch_012',
      name: 'Samarpan Inclusive School',
      type: 'Inclusive',
      board: 'CBSE',
      address: 'Koregaon Park, Pune – 411001',
      city: 'Pune',
      state: 'Maharashtra',
      phone: '+91 96500 99012',
      ageRange: '3–15 years',
      fees: '₹5,000/month',
      therapiesOnCampus: ['Speech', 'OT', 'Counselling'],
      isRTE: false,
      isResidential: false,
    ),
  ];
}
