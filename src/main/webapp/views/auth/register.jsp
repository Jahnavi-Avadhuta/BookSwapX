<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register - BookSwapX</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/bookswapx-theme.css">
<style>
html, body {
	min-height: 100vh;
	background: var(--cream) !important;
	margin: 0;
	padding: 0;
}

.auth-wrapper {
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 2rem 1rem;
	position: relative;
	overflow: hidden;
}

.auth-wrapper::before {
	content: '';
	position: fixed;
	inset: 0;
	background: radial-gradient(ellipse 60% 50% at 10% 90%, rgba(194, 65, 12, .10)
		0%, transparent 60%),
		radial-gradient(ellipse 50% 40% at 90% 10%, rgba(217, 119, 6, .09) 0%,
		transparent 55%),
		radial-gradient(ellipse 40% 40% at 55% 55%, rgba(74, 124, 89, .05) 0%,
		transparent 60%);
	pointer-events: none;
	z-index: 0;
}

.auth-deco {
	position: fixed;
	pointer-events: none;
	z-index: 0;
	opacity: .06;
	font-size: 8rem;
	user-select: none;
}

.auth-deco-1 {
	top: 6%;
	left: 3%;
	font-size: 6rem;
	transform: rotate(-15deg);
}

.auth-deco-2 {
	bottom: 8%;
	right: 4%;
	font-size: 9rem;
	transform: rotate(12deg);
}

.auth-card {
	background: #fff;
	border: 1.5px solid var(--border);
	border-radius: 28px;
	padding: 2.75rem 2.75rem;
	width: 100%;
	max-width: 480px;
	box-shadow: 0 24px 64px rgba(28, 25, 23, .13), 0 4px 16px
		rgba(28, 25, 23, .07);
	position: relative;
	z-index: 1;
	animation: authSlideUp .5s cubic-bezier(.34, 1.4, .64, 1) both;
}

.auth-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	height: 4px;
	background: linear-gradient(90deg, #4A7C59 0%, #D97706 50%, #C2410C 100%);
	border-radius: 28px 28px 0 0;
}

.auth-logo-wrap {
	text-align: center;
	margin-bottom: 1.75rem;
}

.auth-logo-icon {
	width: 72px;
	height: 72px;
	background: linear-gradient(135deg, #C2410C 0%, #D97706 100%);
	border-radius: 20px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	font-size: 2rem;
	line-height: 1;
	color: #fff !important;
	margin-bottom: .85rem;
	box-shadow: 0 8px 24px rgba(194, 65, 12, .35);
}

.auth-logo-icon i {
	color: #fff !important;
	font-size: 2rem !important;
	line-height: 1 !important;
}

.auth-logo-wrap h1 {
	font-family: var(--font-display);
	font-size: 1.9rem;
	font-weight: 900;
	color: var(--ink);
	margin: 0 0 .2rem;
	letter-spacing: -.5px;
}

.auth-logo-wrap p {
	font-size: .875rem;
	color: var(--muted);
	margin: 0;
}

.auth-title {
	font-family: var(--font-body);
	font-size: 1rem;
	font-weight: 500;
	color: var(--muted);
	text-align: center;
	margin-bottom: 1.5rem;
	padding-bottom: 1.5rem;
	border-bottom: 1px solid var(--cream-dark);
}

.fields-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 0 1rem;
}

.field-full {
	grid-column: 1/-1;
}

.auth-label {
	display: block;
	font-size: .75rem;
	font-weight: 700;
	letter-spacing: .07em;
	text-transform: uppercase;
	color: var(--muted);
	margin-bottom: .4rem;
	font-family: var(--font-body);
}

.auth-input {
	width: 100%;
	padding: .72rem 1rem .72rem 2.6rem;
	background: var(--cream);
	border: 1.5px solid var(--border);
	border-radius: 8px;
	font-family: var(--font-body);
	font-size: .9rem;
	color: var(--ink);
	transition: border-color .2s, box-shadow .2s, background .2s;
	outline: none;
}

.auth-input:focus {
	border-color: var(--rust);
	background: #fff;
	box-shadow: 0 0 0 3px rgba(194, 65, 12, .12);
}

.auth-input::placeholder {
	color: #B5AFA9;
}

.input-wrap {
	position: relative;
	margin-bottom: 1rem;
}

.input-icon {
	position: absolute;
	left: .85rem;
	top: 50%;
	transform: translateY(-50%);
	color: var(--muted);
	font-size: 1rem;
	pointer-events: none;
	transition: color .2s;
}

.input-wrap:focus-within .input-icon {
	color: var(--rust);
}

.auth-submit {
	width: 100%;
	padding: .85rem 1.5rem;
	background: #C2410C;
	color: #fff;
	border: none;
	border-radius: 8px;
	font-family: 'DM Sans', sans-serif;
	font-size: .95rem;
	font-weight: 700;
	cursor: pointer;
	transition: background .2s, transform .2s, box-shadow .2s;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: .5rem;
	margin-top: .35rem;
	letter-spacing: .01em;
}

.auth-submit:hover {
	background: #EA580C;
	transform: translateY(-1px);
	box-shadow: 0 6px 16px rgba(194, 65, 12, .3);
}

.auth-submit:active {
	transform: translateY(0);
}

/* Benefits strip */
.auth-benefits {
	display: flex;
	gap: 1rem;
	justify-content: center;
	flex-wrap: wrap;
	margin: 1.35rem 0 1.5rem;
	padding: 1rem;
	background: var(--cream);
	border-radius: 10px;
	border: 1px solid var(--cream-dark);
}

.auth-benefit {
	display: flex;
	align-items: center;
	gap: .35rem;
	font-size: .78rem;
	color: var(--muted);
	font-weight: 500;
}

.auth-benefit i {
	color: var(--sage);
}

.auth-footer-link {
	text-align: center;
	margin-top: 1.5rem;
	padding-top: 1.5rem;
	border-top: 1px solid var(--cream-dark);
	font-size: .875rem;
	color: var(--muted);
}

.auth-footer-link a {
	color: var(--rust);
	font-weight: 600;
	text-decoration: none;
}

.auth-footer-link a:hover {
	color: var(--rust-light);
	text-decoration: underline;
}

.auth-alert {
	padding: .75rem 1rem;
	border-radius: 8px;
	border-left: 4px solid;
	font-size: .85rem;
	margin-bottom: 1.25rem;
	display: flex;
	align-items: center;
	gap: .6rem;
}

.auth-alert-danger {
	background: rgba(194, 65, 12, .08);
	border-color: var(--rust);
	color: #9A1D04;
}

@
keyframes authSlideUp {from { opacity:0;
	transform: translateY(28px) scale(.97);
}

to {
	opacity: 1;
	transform: translateY(0) scale(1);
}

}
@media ( max-width : 500px) {
	.auth-card {
		padding: 2rem 1.5rem;
		border-radius: 20px;
	}
	.fields-grid {
		grid-template-columns: 1fr;
	}
}
</style>
</head>
<body>
	<div class="auth-wrapper">

		<span class="auth-deco auth-deco-1">📚</span> <span
			class="auth-deco auth-deco-2">📖</span>

		<div class="auth-card">

			<div class="auth-logo-wrap">
				<div class="auth-logo-icon">📚</div>
				<h1>BookSwapX</h1>
				<p>Join thousands of students swapping books for free</p>
			</div>

			<p class="auth-title">Create your account — it's free</p>

			<div class="auth-benefits">
				<span class="auth-benefit"><i class="bi bi-check-circle-fill"></i>
					Free forever</span> <span class="auth-benefit"><i
					class="bi bi-check-circle-fill"></i> Smart matching</span> <span
					class="auth-benefit"><i class="bi bi-check-circle-fill"></i>
					Zero cost swaps</span>
			</div>

			<%
			if (request.getAttribute("error") != null) {
			%>
			<div class="auth-alert auth-alert-danger">
				<i class="bi bi-exclamation-circle-fill"></i>
				<%=request.getAttribute("error")%>
			</div>
			<%
			}
			%>

			<form action="${pageContext.request.contextPath}/auth/register"
				method="post">
				<div class="fields-grid">

					<div class="field-full">
						<label class="auth-label">Username</label>
						<div class="input-wrap">
							<i class="bi bi-person input-icon"></i> <input type="text"
								name="username" class="auth-input"
								placeholder="Choose a username" required>
						</div>
					</div>

					<div class="field-full">
						<label class="auth-label">Email address</label>
						<div class="input-wrap">
							<i class="bi bi-envelope input-icon"></i> <input type="email"
								name="email" class="auth-input" placeholder="you@example.com"
								required>
						</div>
					</div>

					<div>
						<label class="auth-label">Password</label>
						<div class="input-wrap">
							<i class="bi bi-lock input-icon"></i> <input type="password"
								name="password" class="auth-input" placeholder="Create password"
								required>
						</div>
					</div>

					<div>
						<label class="auth-label">Location</label>
						<div class="input-wrap">
							<i class="bi bi-geo-alt input-icon"></i> <input type="text"
								name="location" class="auth-input" placeholder="e.g. Hyderabad"
								required>
						</div>
					</div>

				</div>

				<button type="submit" class="auth-submit">
					<i class="bi bi-person-plus"></i> Create Account
				</button>
			</form>

			<div class="auth-footer-link">
				Already have an account? <a
					href="${pageContext.request.contextPath}/auth/login">Login here</a>
			</div>

		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
