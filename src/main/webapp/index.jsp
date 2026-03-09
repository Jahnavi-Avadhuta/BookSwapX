<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BookSwapX — Exchange Books, Expand Minds</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400;1,700&family=DM+Sans:wght@300;400;500;600&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet">
<style>
:root {
  --cream: #F5F0E8;
  --paper: #EDE8DC;
  --ink: #2C2416;
  --brown: #8B5E3C;
  --gold: #C9A84C;
  --rust: #C4622D;
  --sage: #7A9E7E;
  --warm: #FDFAF5;
  --muted: rgba(44,36,22,0.55);
  --border: rgba(139,94,60,0.18);
}
*, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }
html { scroll-behavior:smooth; }
body { background:var(--cream); color:var(--ink); font-family:'DM Sans',sans-serif; overflow-x:hidden; }
body::after {
  content:''; position:fixed; inset:0;
  background-image:url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.75' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.03'/%3E%3C/svg%3E");
  pointer-events:none; z-index:9999; opacity:0.3;
}

/* NAVBAR */
header {
  position:fixed; top:0; left:0; right:0; z-index:100;
  padding:16px 60px;
  display:flex; align-items:center; justify-content:space-between;
  background:rgba(245,240,232,0.9);
  backdrop-filter:blur(16px);
  border-bottom:1px solid var(--border);
  transition:box-shadow 0.3s;
}
.logo { display:flex; align-items:center; gap:10px; text-decoration:none; }
.logo-icon {
  width:38px; height:38px;
  background:linear-gradient(135deg,var(--brown),var(--rust));
  border-radius:9px;
  display:flex; align-items:center; justify-content:center;
  font-size:18px; transform:rotate(-4deg); transition:transform 0.3s;
  box-shadow:0 3px 12px rgba(139,94,60,0.3);
}
.logo:hover .logo-icon { transform:rotate(4deg); }
.logo-name { font-family:'Playfair Display',serif; font-size:21px; font-weight:700; color:var(--ink); letter-spacing:-0.5px; }
.logo-name span { color:var(--rust); }
nav { display:flex; align-items:center; gap:8px; }
nav a { text-decoration:none; color:var(--ink); font-size:14px; font-weight:500; opacity:0.65; padding:8px 14px; border-radius:7px; transition:all 0.2s; }
nav a:hover { opacity:1; background:rgba(139,94,60,0.08); }
.nav-btn { background:var(--ink) !important; color:var(--cream) !important; opacity:1 !important; padding:9px 22px !important; border-radius:8px !important; font-weight:500 !important; transition:all 0.2s !important; box-shadow:0 2px 10px rgba(44,36,22,0.2); }
.nav-btn:hover { background:var(--brown) !important; transform:translateY(-1px) !important; box-shadow:0 4px 18px rgba(44,36,22,0.25) !important; }

/* TICKER */
.ticker {
  background: linear-gradient(90deg, #C9A84C, #D4A840, #C9A84C);
  padding: 11px 0;
  overflow: hidden;
  white-space: nowrap;
  margin-top: 70px;
  position: relative;
  z-index: 10;
}
.ticker-track {
  display: inline-flex;
  white-space: nowrap;
}
.ticker-item {
  display: inline-flex;
  align-items: center;
  gap: 14px;
  padding: 0 28px;
  font-family: 'DM Mono', monospace;
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 1.5px;
  text-transform: uppercase;
  color: #2C2416;
  flex-shrink: 0;
}
.ticker-dot {
  width: 3px; height: 3px;
  background: #2C2416;
  border-radius: 50%;
  opacity: 0.4;
  flex-shrink: 0;
}

/* HERO */
.hero {
  min-height:100vh;
  display:grid; grid-template-columns:1fr 1fr;
  padding:100px 60px 80px; gap:60px;
  align-items:center; position:relative; overflow:hidden;
}
.hero::before {
  content:''; position:absolute; top:0; right:0; width:55%; height:100%;
  background:linear-gradient(135deg,rgba(201,168,76,0.07) 0%,rgba(122,158,126,0.06) 100%);
  clip-path:polygon(10% 0,100% 0,100% 100%,0% 100%); pointer-events:none;
}
.hero-badge {
  display:inline-flex; align-items:center; gap:8px;
  background:rgba(122,158,126,0.12); border:1.5px solid rgba(122,158,126,0.3);
  padding:6px 16px; border-radius:100px;
  font-size:12px; font-weight:600; color:#4A7A4E;
  letter-spacing:0.5px; text-transform:uppercase; margin-bottom:28px;
  animation:fadeUp 0.5s ease both;
}
.hero-badge::before { content:''; width:7px; height:7px; background:var(--sage); border-radius:50%; animation:pulse 2s infinite; }
.hero-title { font-family:'Playfair Display',serif; font-size:clamp(46px,5.5vw,78px); font-weight:900; line-height:1.04; letter-spacing:-2.5px; color:var(--ink); margin-bottom:20px; animation:fadeUp 0.5s ease 0.1s both; }
.hero-title em { font-style:italic; color:var(--rust); }
.hero-title .ul-word { position:relative; display:inline-block; }
.hero-title .ul-word::after { content:''; position:absolute; bottom:2px; left:0; right:0; height:4px; background:linear-gradient(to right,var(--gold),var(--rust)); border-radius:2px; transform-origin:left; animation:grow 0.8s ease 0.9s both; }
.hero-slogan { font-family:'DM Mono',monospace; font-size:15px; color:var(--brown); margin-bottom:18px; letter-spacing:0.5px; animation:fadeUp 0.5s ease 0.2s both; }
.hero-desc { font-size:16px; line-height:1.75; color:var(--muted); max-width:480px; margin-bottom:40px; animation:fadeUp 0.5s ease 0.3s both; }
.hero-btns { display:flex; gap:14px; align-items:center; animation:fadeUp 0.5s ease 0.4s both; }
.btn-hero { background:linear-gradient(135deg,var(--rust),#A84E1E); color:white; padding:15px 34px; border-radius:9px; text-decoration:none; font-weight:600; font-size:15px; transition:all 0.25s; box-shadow:0 4px 20px rgba(196,98,45,0.35); }
.btn-hero:hover { transform:translateY(-2px); box-shadow:0 8px 28px rgba(196,98,45,0.45); }
.btn-ghost { color:var(--ink); text-decoration:none; font-weight:500; font-size:15px; display:flex; align-items:center; gap:6px; opacity:0.65; transition:all 0.2s; padding:15px 4px; }
.btn-ghost:hover { opacity:1; gap:12px; }
.hero-stats { display:flex; gap:36px; margin-top:52px; padding-top:36px; border-top:1px solid var(--border); animation:fadeUp 0.5s ease 0.5s both; }
.stat { display:flex; flex-direction:column; gap:3px; }
.stat-num { font-family:'Playfair Display',serif; font-size:30px; font-weight:900; color:var(--ink); }
.stat-lbl { font-family:'DM Mono',monospace; font-size:10px; text-transform:uppercase; letter-spacing:1.2px; color:var(--muted); }

/* BOOK STACK */
.hero-visual { display:flex; align-items:center; justify-content:center; position:relative; z-index:2; animation:fadeUp 0.5s ease 0.2s both; }
.book-stack { position:relative; width:300px; height:400px; }
.book { position:absolute; border-radius:4px 14px 14px 4px; box-shadow:6px 8px 24px rgba(0,0,0,0.18); display:flex; align-items:center; justify-content:center; transition:transform 0.4s ease; cursor:default; }
.book-label { font-family:'Playfair Display',serif; color:rgba(255,255,255,0.75); font-size:15px; font-weight:700; text-align:center; line-height:1.4; padding:16px; }
.book-1 { width:210px; height:290px; background:linear-gradient(140deg,#8B5E3C 0%,#5C3A1E 100%); top:55px; left:15px; transform:rotate(-9deg); }
.book-2 { width:200px; height:275px; background:linear-gradient(140deg,#C4622D 0%,#8B3A14 100%); top:75px; left:65px; transform:rotate(2deg); }
.book-3 { width:185px; height:255px; background:linear-gradient(140deg,#7A9E7E 0%,#4A6E4E 100%); top:95px; left:115px; transform:rotate(11deg); }
.book-stack:hover .book-1 { transform:rotate(-13deg) translateY(-12px); }
.book-stack:hover .book-2 { transform:rotate(-1deg) translateY(-18px); }
.book-stack:hover .book-3 { transform:rotate(15deg) translateY(-10px); }
.float-badge { position:absolute; bottom:10px; right:-10px; background:var(--ink); color:var(--cream); padding:14px 18px; border-radius:14px; font-size:13px; font-weight:500; line-height:1.5; box-shadow:0 8px 28px rgba(0,0,0,0.22); animation:float 3s ease-in-out infinite; }
.float-badge strong { display:block; font-family:'Playfair Display',serif; font-size:19px; color:var(--gold); }

/* HOW IT WORKS */
.how { padding:110px 60px; background:var(--ink); position:relative; overflow:hidden; }
.how::before { content:''; position:absolute; top:-80px; right:-80px; width:400px; height:400px; background:radial-gradient(circle,rgba(201,168,76,0.12) 0%,transparent 65%); pointer-events:none; }
.how::after { content:''; position:absolute; bottom:-60px; left:-60px; width:300px; height:300px; background:radial-gradient(circle,rgba(122,158,126,0.1) 0%,transparent 65%); pointer-events:none; }
.sec-tag { font-family:'DM Mono',monospace; font-size:11px; text-transform:uppercase; letter-spacing:3px; color:var(--gold); margin-bottom:12px; display:block; }
.sec-title { font-family:'Playfair Display',serif; font-size:clamp(34px,4vw,50px); font-weight:900; letter-spacing:-1.5px; line-height:1.1; margin-bottom:14px; }
.sec-sub { font-size:16px; line-height:1.7; max-width:480px; margin-bottom:64px; }
.steps { display:grid; grid-template-columns:repeat(4,1fr); gap:24px; position:relative; }
.steps::before { content:''; position:absolute; top:40px; left:8%; right:8%; height:1px; background:linear-gradient(to right,transparent,rgba(201,168,76,0.3) 20%,rgba(201,168,76,0.3) 80%,transparent); }
.step { background:rgba(255,255,255,0.05); border:1px solid rgba(255,255,255,0.1); border-radius:16px; padding:36px 28px; transition:all 0.3s ease; position:relative; overflow:hidden; }
.step::before { content:''; position:absolute; top:0; left:0; right:0; height:2px; background:linear-gradient(to right,var(--gold),var(--rust)); opacity:0; transition:opacity 0.3s; }
.step:hover { background:rgba(255,255,255,0.08); transform:translateY(-6px); box-shadow:0 20px 50px rgba(0,0,0,0.3); }
.step:hover::before { opacity:1; }
.step-num {
  font-family:'Playfair Display',serif;
  font-size:52px; font-weight:900;
  line-height:1; margin-bottom:16px;
  background:linear-gradient(135deg,#C9A84C 0%,#F0C060 60%,#C9A84C 100%);
  -webkit-background-clip:text;
  -webkit-text-fill-color:transparent;
  background-clip:text;
  display:block;
  filter:drop-shadow(0 2px 6px rgba(201,168,76,0.3));
}
.step-icon { font-size:26px; margin-bottom:14px; display:block; }
.step-title { font-family:'Playfair Display',serif; font-size:19px; font-weight:700; margin-bottom:10px; color:var(--cream); }
.step-desc { font-size:13px; line-height:1.7; color:rgba(245,240,232,0.55); }

/* FEATURES */
.features { padding:110px 60px; display:grid; grid-template-columns:1fr 1fr; gap:80px; align-items:center; background:var(--cream); }
.feat-grid { display:grid; grid-template-columns:1fr 1fr; gap:18px; }
.feat-card { background:var(--warm); border:1.5px solid var(--border); border-radius:14px; padding:26px; transition:all 0.3s ease; cursor:default; }
.feat-card:hover { background:var(--ink); border-color:var(--ink); transform:scale(1.03); box-shadow:0 12px 36px rgba(44,36,22,0.15); }
.feat-card:hover .feat-title, .feat-card:hover .feat-desc { color:var(--cream); }
.feat-card:hover .feat-icon { background:rgba(255,255,255,0.1); }
.feat-icon { width:42px; height:42px; background:rgba(139,94,60,0.1); border-radius:10px; display:flex; align-items:center; justify-content:center; font-size:19px; margin-bottom:14px; transition:background 0.3s; }
.feat-title { font-family:'Playfair Display',serif; font-size:16px; font-weight:700; margin-bottom:7px; color:var(--ink); transition:color 0.3s; }
.feat-desc { font-size:13px; line-height:1.6; color:var(--muted); transition:color 0.3s; }
.feat-card.wide { grid-column:span 2; display:flex; align-items:center; gap:20px; }

/* QUOTES */
.quotes { padding:100px 60px; background:linear-gradient(135deg,#1A0F05 0%,var(--ink) 60%,#1A2A1A 100%); position:relative; overflow:hidden; }
.quotes::before { content:'❝'; position:absolute; top:-60px; left:20px; font-size:280px; font-family:'Playfair Display',serif; color:rgba(201,168,76,0.05); line-height:1; pointer-events:none; }
.quotes-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:28px; position:relative; z-index:1; }
.q-card { background:rgba(255,255,255,0.04); border:1px solid rgba(255,255,255,0.08); border-radius:16px; padding:32px; transition:all 0.3s; }
.q-card:hover { background:rgba(255,255,255,0.07); border-color:rgba(201,168,76,0.2); transform:translateY(-4px); }
.q-text { font-family:'Playfair Display',serif; font-size:16px; font-style:italic; line-height:1.75; color:rgba(245,240,232,0.82); margin-bottom:22px; }
.q-author { display:flex; align-items:center; gap:12px; }
.q-avatar { width:38px; height:38px; border-radius:50%; background:linear-gradient(135deg,var(--brown),var(--rust)); display:flex; align-items:center; justify-content:center; font-weight:700; font-size:15px; color:white; flex-shrink:0; }
.q-name { font-size:14px; font-weight:600; color:var(--cream); }
.q-role { font-size:12px; color:rgba(245,240,232,0.4); margin-top:2px; }

/* CTA */
.cta { padding:110px 60px; text-align:center; background:var(--paper); position:relative; overflow:hidden; }
.cta::before { content:''; position:absolute; top:50%; left:50%; transform:translate(-50%,-50%); width:700px; height:350px; background:radial-gradient(ellipse,rgba(196,98,45,0.07) 0%,transparent 70%); pointer-events:none; }
.cta-title { font-family:'Playfair Display',serif; font-size:clamp(40px,5.5vw,68px); font-weight:900; letter-spacing:-2px; line-height:1.05; color:var(--ink); margin-bottom:22px; position:relative; z-index:1; }
.cta-title em { color:var(--rust); font-style:italic; }
.cta-desc { font-size:16px; color:var(--muted); max-width:460px; margin:0 auto 44px; line-height:1.75; position:relative; z-index:1; }
.cta-btns { display:flex; gap:16px; justify-content:center; align-items:center; position:relative; z-index:1; }
.btn-cta { background:linear-gradient(135deg,var(--rust),#A84E1E); color:white; padding:17px 44px; border-radius:10px; text-decoration:none; font-weight:600; font-size:16px; transition:all 0.25s; box-shadow:0 4px 20px rgba(196,98,45,0.3); }
.btn-cta:hover { transform:translateY(-2px); box-shadow:0 8px 28px rgba(196,98,45,0.4); }
.btn-cta-out { padding:17px 44px; border:2px solid var(--ink); color:var(--ink); text-decoration:none; font-weight:600; font-size:16px; border-radius:10px; transition:all 0.25s; }
.btn-cta-out:hover { background:var(--ink); color:var(--cream); transform:translateY(-2px); }

/* FOOTER */
footer { background:var(--ink); color:var(--cream); padding:56px 60px; }
.footer-top { display:grid; grid-template-columns:2fr 1fr 1fr 1fr; gap:56px; padding-bottom:44px; border-bottom:1px solid rgba(255,255,255,0.08); margin-bottom:36px; }
.f-brand-name { font-family:'Playfair Display',serif; font-size:22px; font-weight:700; color:var(--cream); margin-bottom:14px; display:block; letter-spacing:-0.5px; }
.f-brand-name span { color:var(--rust); }
.f-brand p { font-size:13px; line-height:1.7; color:rgba(245,240,232,0.4); max-width:260px; }
.f-col h5 { font-family:'Playfair Display',serif; font-size:14px; font-weight:700; color:var(--cream); margin-bottom:18px; }
.f-col a { display:block; text-decoration:none; color:rgba(245,240,232,0.42); font-size:13px; margin-bottom:9px; transition:color 0.2s; }
.f-col a:hover { color:var(--cream); }
.footer-bottom { display:flex; justify-content:space-between; align-items:center; }
.footer-bottom p { font-size:12px; color:rgba(245,240,232,0.28); }
.footer-bottom p span { color:var(--gold); }
.f-tagline { font-family:'DM Mono',monospace; font-size:10px; letter-spacing:2.5px; text-transform:uppercase; color:rgba(245,240,232,0.2); }

/* Animations */
@keyframes fadeUp { from { opacity:0; transform:translateY(20px); } to { opacity:1; transform:translateY(0); } }
@keyframes grow   { from { transform:scaleX(0); } to { transform:scaleX(1); } }
@keyframes float  { 0%,100% { transform:translateY(0); } 50% { transform:translateY(-10px); } }
@keyframes pulse  { 0%,100% { opacity:1; transform:scale(1); } 50% { opacity:0.4; transform:scale(1.4); } }

.reveal { opacity:0; transform:translateY(24px); transition:opacity 0.6s ease,transform 0.6s ease; }
.reveal.visible { opacity:1; transform:translateY(0); }

@media (max-width:1024px) {
  .hero { grid-template-columns:1fr; padding:100px 40px 60px; }
  .hero-visual { display:none; }
  .steps { grid-template-columns:repeat(2,1fr); }
  .features { grid-template-columns:1fr; }
  .quotes-grid { grid-template-columns:1fr; }
  .footer-top { grid-template-columns:1fr 1fr; }
}
@media (max-width:768px) {
  header { padding:14px 20px; }
  nav a:not(.nav-btn) { display:none; }
  .hero { padding:90px 20px 56px; }
  .how,.features,.quotes,.cta,footer { padding:72px 20px; }
  .steps { grid-template-columns:1fr; }
  .feat-grid { grid-template-columns:1fr; }
  .feat-card.wide { flex-direction:column; }
  .cta-btns { flex-direction:column; }
  .footer-top { grid-template-columns:1fr; gap:32px; }
  .footer-bottom { flex-direction:column; gap:10px; text-align:center; }
}
</style>
</head>
<body>

<!-- HEADER -->
<header id="top-header">
  <a href="#" class="logo">
    <div class="logo-icon">📚</div>
    <span class="logo-name">Book<span>Swap</span>X</span>
  </a>
  <nav>
    <a href="#how">How It Works</a>
    <a href="#features">Features</a>
    <a href="<%=request.getContextPath()%>/views/auth/login.jsp">Login</a>
    <a href="<%=request.getContextPath()%>/views/auth/register.jsp" class="nav-btn">Get Started →</a>
  </nav>
</header>

<!-- TICKER -->
<div class="ticker" id="ticker">
  <div class="ticker-track" id="ticker-track">
    <span class="ticker-item">Exchange Books for Free <span class="ticker-dot"></span></span>
    <span class="ticker-item">Zero Cost Swaps <span class="ticker-dot"></span></span>
    <span class="ticker-item">Smart Auto Matching Engine <span class="ticker-dot"></span></span>
    <span class="ticker-item">College Book Exchange Platform <span class="ticker-dot"></span></span>
    <span class="ticker-item">Post. Match. Swap. Done. <span class="ticker-dot"></span></span>
    <span class="ticker-item">Exchange Books for Free <span class="ticker-dot"></span></span>
    <span class="ticker-item">Zero Cost Swaps <span class="ticker-dot"></span></span>
    <span class="ticker-item">Smart Auto Matching Engine <span class="ticker-dot"></span></span>
    <span class="ticker-item">College Book Exchange Platform <span class="ticker-dot"></span></span>
    <span class="ticker-item">Post. Match. Swap. Done. <span class="ticker-dot"></span></span>
  </div>
</div>

<!-- HERO -->
<section class="hero">
  <div class="hero-left">
    <span class="hero-badge">🎓 Built for College Students</span>
    <h1 class="hero-title">Your books<br>deserve a<br><span class="ul-word">second life</span></h1>
    <p class="hero-slogan">// Exchange Books. Expand Minds. Pay Nothing.</p>
    <p class="hero-desc">BookSwapX connects students who have books others want, and want books others have. Our smart matching engine finds your perfect swap automatically — completely free.</p>
    <div class="hero-btns">
      <a href="<%=request.getContextPath()%>/views/auth/register.jsp" class="btn-hero">Start Swapping Free →</a>
      <a href="<%=request.getContextPath()%>/views/auth/login.jsp" class="btn-ghost">Already a member? Login <span>→</span></a>
    </div>
    <div class="hero-stats">
      <div class="stat"><span class="stat-num">100%</span><span class="stat-lbl">Free Exchanges</span></div>
      <div class="stat"><span class="stat-num">₹0</span><span class="stat-lbl">Cost to Swap</span></div>
      <div class="stat"><span class="stat-num">Smart</span><span class="stat-lbl">Auto Matching</span></div>
    </div>
  </div>
  <div class="hero-visual">
    <div class="book-stack">
      <div class="book book-1"><div class="book-label">Data<br>Structures</div></div>
      <div class="book book-2"><div class="book-label">Java<br>Programming</div></div>
      <div class="book book-3"><div class="book-label">Operating<br>Systems</div></div>
      <div class="float-badge">
        <strong>FREE ↔</strong> Perfect Match Found!<br>
        <small style="opacity:0.55;font-size:11px;">Exchange instantly</small>
      </div>
    </div>
  </div>
</section>

<!-- HOW IT WORKS -->
<section class="how" id="how">
  <div style="max-width:1200px;margin:0 auto;">
    <span class="sec-tag">Process</span>
    <h2 class="sec-title" style="color:var(--cream);">How BookSwapX<br><em style="color:var(--gold);font-style:italic;">works</em></h2>
    <p class="sec-sub" style="color:rgba(245,240,232,0.55);">Four simple steps to exchange your books without spending a single rupee.</p>
    <div class="steps">
      <div class="step reveal">
        <span class="step-num">01</span>
        <span class="step-icon">📝</span>
        <h3 class="step-title">Post Your Books</h3>
        <p class="step-desc">List books you want to sell or exchange. Add title, author, condition and your location.</p>
      </div>
      <div class="step reveal">
        <span class="step-num">02</span>
        <span class="step-icon">⚡</span>
        <h3 class="step-title">Smart Matching</h3>
        <p class="step-desc">Our engine automatically finds users who have what you want and want what you have — in your area.</p>
      </div>
      <div class="step reveal">
        <span class="step-num">03</span>
        <span class="step-icon">💬</span>
        <h3 class="step-title">Connect & Chat</h3>
        <p class="step-desc">Message your match directly. Discuss meetup location, condition, timing — all within the app.</p>
      </div>
      <div class="step reveal">
        <span class="step-num">04</span>
        <span class="step-icon">🔄</span>
        <h3 class="step-title">Exchange Free</h3>
        <p class="step-desc">Meet up and swap books. Zero cost. Both get what they need. Review each other after.</p>
      </div>
    </div>
  </div>
</section>

<!-- FEATURES -->
<section class="features" id="features">
  <div>
    <span class="sec-tag" style="color:var(--brown);">Features</span>
    <h2 class="sec-title" style="color:var(--ink);">Everything you need<br>to swap <em style="color:var(--rust);font-style:italic;">smarter</em></h2>
    <p class="sec-sub" style="color:var(--muted);">Built with real college students in mind.<br>Every feature solves a real problem.</p>
    <a href="<%=request.getContextPath()%>/views/auth/register.jsp" class="btn-hero" style="display:inline-block;margin-top:4px;">Join for Free →</a>
  </div>
  <div class="feat-grid">
    <div class="feat-card reveal"><div class="feat-icon">⚡</div><h4 class="feat-title">Instant Matching</h4><p class="feat-desc">Database trigger fires the moment you post — finds your match in milliseconds.</p></div>
    <div class="feat-card reveal"><div class="feat-icon">📍</div><h4 class="feat-title">Location Based</h4><p class="feat-desc">Only matches users in the same area — no long-distance hassles.</p></div>
    <div class="feat-card reveal"><div class="feat-icon">💬</div><h4 class="feat-title">Built-in Chat</h4><p class="feat-desc">Message any user directly without sharing personal contact info.</p></div>
    <div class="feat-card reveal"><div class="feat-icon">⭐</div><h4 class="feat-title">Trust Scores</h4><p class="feat-desc">Rate users after exchange. Build your reputation. Know who to trust.</p></div>
    <div class="feat-card wide reveal"><div class="feat-icon" style="flex-shrink:0;">🔒</div><div><h4 class="feat-title">Safe & Secure</h4><p class="feat-desc">Secure login, password hashing, session management, admin moderation and reporting system keeps the community safe.</p></div></div>
  </div>
</section>

<!-- QUOTES -->
<section class="quotes">
  <div style="text-align:center;margin-bottom:56px;position:relative;z-index:1;">
    <span class="sec-tag">Community</span>
    <h2 class="sec-title" style="color:var(--cream);">What students<br><em style="color:var(--gold);font-style:italic;">are saying</em></h2>
  </div>
  <div class="quotes-grid">
    <div class="q-card reveal">
      <p class="q-text">"I exchanged my Data Structures book for Operating Systems — both of us saved ₹400. This platform is exactly what college students needed."</p>
      <div class="q-author"><div class="q-avatar">R</div><div><div class="q-name">Ravi Kumar</div><div class="q-role">CSE, 3rd Year</div></div></div>
    </div>
    <div class="q-card reveal">
      <p class="q-text">"Found someone in my college who had exactly the book I needed and wanted mine. Matched within minutes of posting. Incredible!"</p>
      <div class="q-author"><div class="q-avatar">P</div><div><div class="q-name">Priya Sharma</div><div class="q-role">ECE, 2nd Year</div></div></div>
    </div>
    <div class="q-card reveal">
      <p class="q-text">"The trust score system gives me confidence. I can see who's reliable before agreeing to swap. Smart design for a real problem."</p>
      <div class="q-author"><div class="q-avatar">A</div><div><div class="q-name">Arjun Mehta</div><div class="q-role">IT, 4th Year</div></div></div>
    </div>
  </div>
</section>

<!-- CTA -->
<section class="cta">
  <h2 class="cta-title">Stop buying.<br>Start <em>swapping.</em></h2>
  <p class="cta-desc">Join students exchanging books for free. Post your first listing in under 2 minutes.</p>
  <div class="cta-btns">
    <a href="<%=request.getContextPath()%>/views/auth/register.jsp" class="btn-cta">Create Free Account →</a>
    <a href="<%=request.getContextPath()%>/views/auth/login.jsp" class="btn-cta-out">Sign In</a>
  </div>
</section>

<!-- FOOTER -->
<footer>
  <div class="footer-top">
    <div class="f-brand">
      <span class="f-brand-name">Book<span>Swap</span>X</span>
      <p>A smart book exchange platform built for college students. Exchange books, expand minds, pay nothing.</p>
    </div>
    <div class="f-col">
      <h5>Platform</h5>
      <a href="<%=request.getContextPath()%>/views/auth/register.jsp">Register</a>
      <a href="<%=request.getContextPath()%>/views/auth/login.jsp">Login</a>
      <a href="<%=request.getContextPath()%>/search">Browse Books</a>
    </div>
    <div class="f-col">
      <h5>Features</h5>
      <a href="#">Book Exchange</a>
      <a href="#">Smart Matching</a>
      <a href="#">Messaging</a>
      <a href="#">Trust Scores</a>
    </div>
    <div class="f-col">
      <h5>Info</h5>
      <a href="#how">How It Works</a>
      <a href="#features">Features</a>
      <a href="<%=request.getContextPath()%>/views/auth/register.jsp">Get Started</a>
    </div>
  </div>
  <div class="footer-bottom">
    <p>© 2025 BookSwapX. Built with ❤️ for students. <span>All exchanges are free.</span></p>
    <span class="f-tagline">// Exchange Books. Expand Minds.</span>
  </div>
</footer>

<script>
  // TICKER — JS driven, immune to JSP/Eclipse formatter issues
  (function() {
    var track = document.getElementById('ticker-track');
    if (!track) return;
    var ticker = document.getElementById('ticker');

    // Create mover wrapper
    var mover = document.createElement('div');
    mover.style.cssText = 'display:inline-flex;white-space:nowrap;will-change:transform;';
    ticker.appendChild(mover);

    // Clone track for seamless loop
    var clone = track.cloneNode(true);
    mover.appendChild(track);
    mover.appendChild(clone);

    var pos = 0;
    var speed = 0.7;
    var paused = false;

    ticker.addEventListener('mouseenter', function(){ paused = true; });
    ticker.addEventListener('mouseleave', function(){ paused = false; });

    function animate() {
      if (!paused) {
        pos -= speed;
        if (Math.abs(pos) >= track.offsetWidth) pos = 0;
        mover.style.transform = 'translateX(' + pos + 'px)';
      }
      requestAnimationFrame(animate);
    }
    requestAnimationFrame(animate);
  })();

  // Scroll reveal
  const reveals = document.querySelectorAll('.reveal');
  const obs = new IntersectionObserver((entries) => {
    entries.forEach((entry, i) => {
      if (entry.isIntersecting) {
        setTimeout(() => entry.target.classList.add('visible'), i * 120);
      }
    });
  }, { threshold: 0.1 });
  reveals.forEach(el => obs.observe(el));

  // Header shadow on scroll
  window.addEventListener('scroll', () => {
    document.getElementById('top-header').style.boxShadow =
      window.scrollY > 40 ? '0 4px 24px rgba(44,36,22,0.1)' : 'none';
  });
</script>
</body>
</html>