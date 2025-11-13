<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<%
    User user = (User) session.getAttribute("user");
    String from = (String) session.getAttribute("from");
    session.removeAttribute("from");

    String contextPath = request.getContextPath();

    String heading;
    String status;
    String description;
    String primaryCtaHref;
    String primaryCtaLabel;
    String secondaryCtaHref;
    String secondaryCtaLabel;
    String highlightTitle;
    String highlightDetail;
    String highlightLinkHref;
    String highlightLinkLabel;

    if (user != null) {
        if ("register".equals(from)) {
            heading = "Welcome to IoT Bay, " + user.getFirstName() + "!";
            status = "Registration confirmed";
            description = "You're all set to explore industrial-grade hardware, developer kits, and deployment-ready IoT bundles.";
            primaryCtaHref = contextPath + "/browse.jsp";
            primaryCtaLabel = "Start browsing products";
            secondaryCtaHref = contextPath + "/updateProfile.jsp";
            secondaryCtaLabel = "Complete your profile";
            highlightTitle = "Activate your new account";
            highlightDetail = "Save default shipping details and communication preferences so checkout stays quick across devices.";
            highlightLinkHref = contextPath + "/updateProfile.jsp";
            highlightLinkLabel = "Update profile";
        } else {
            heading = "Welcome back, " + user.getFirstName() + "!";
            status = "You're signed in";
            description = "Pick up where you left off—saved carts, recommendations, and order activity are synced to your account.";
            primaryCtaHref = contextPath + "/";
            primaryCtaLabel = "Continue to homepage";
            secondaryCtaHref = contextPath + "/orderList.jsp";
            secondaryCtaLabel = "View recent orders";
            highlightTitle = "Account snapshot";
            highlightDetail = "Review open orders, manage payment options, or jump back into active projects in one place.";
            highlightLinkHref = contextPath + "/Profiles.jsp";
            highlightLinkLabel = "Manage account";
        }
    } else {
        heading = "Welcome to IoT Bay!";
        status = "Connected experiences await";
        description = "Discover certified gateways, sensors, and partner services that bring resilient, human-centered IoT deployments to life.";
        primaryCtaHref = contextPath + "/browse.jsp";
        primaryCtaLabel = "Browse the catalogue";
        secondaryCtaHref = contextPath + "/register.jsp";
        secondaryCtaLabel = "Create an account";
        highlightTitle = "New to IoT Bay?";
        highlightDetail = "Sign up to track orders, access compatibility tooling, and receive implementation guidance tailored to your industry.";
        highlightLinkHref = contextPath + "/login.jsp";
        highlightLinkLabel = "Sign in";
    }

    request.setAttribute("welcomeHeading", heading);
    request.setAttribute("welcomeStatus", status);
    request.setAttribute("welcomeDescription", description);
    request.setAttribute("primaryCtaHref", primaryCtaHref);
    request.setAttribute("primaryCtaLabel", primaryCtaLabel);
    request.setAttribute("secondaryCtaHref", secondaryCtaHref);
    request.setAttribute("secondaryCtaLabel", secondaryCtaLabel);
    request.setAttribute("highlightTitle", highlightTitle);
    request.setAttribute("highlightDetail", highlightDetail);
    request.setAttribute("highlightLinkHref", highlightLinkHref);
    request.setAttribute("highlightLinkLabel", highlightLinkLabel);
%>

<t:base title="Welcome" description="Welcome to IoT Bay — trusted IoT solutions, expert support, and deployment-ready hardware.">
    <section class="py-16">
        <div class="container space-y-12">
            <div class="grid gap-10 lg:grid-cols-[minmax(0,1fr)_minmax(0,340px)] items-start">
                <div class="rounded-2xl border border-neutral-200 bg-white shadow-sm p-10 space-y-8">
                    <span class="inline-flex items-center gap-2 rounded-full bg-neutral-100 px-3 py-1 text-sm font-semibold text-neutral-700">
                        <span class="inline-flex h-2 w-2 rounded-full bg-brand-primary"></span>
                        ${welcomeStatus}
                    </span>
                    <div class="space-y-4">
                        <h1 class="text-display-l font-bold text-neutral-900 leading-tight">
                            ${welcomeHeading}
                        </h1>
                        <p class="text-lg text-neutral-600 max-w-3xl">
                            ${welcomeDescription}
                        </p>
                    </div>
                    <div class="flex flex-col gap-3 sm:flex-row">
                        <a href="${primaryCtaHref}" class="btn btn--primary btn--lg sm:flex-1" aria-label="${primaryCtaLabel}">
                            ${primaryCtaLabel}
                        </a>
                        <a href="${secondaryCtaHref}" class="btn btn--outline btn--lg sm:flex-1" aria-label="${secondaryCtaLabel}">
                            ${secondaryCtaLabel}
                        </a>
                    </div>
                    <div class="grid gap-4 sm:grid-cols-2">
                        <div class="rounded-2xl border border-neutral-200 bg-neutral-50 p-6 space-y-3" role="group" aria-label="Free shipping">
                            <h2 class="text-sm font-semibold text-neutral-700 uppercase tracking-wide">Free shipping</h2>
                            <p class="text-sm text-neutral-600">Orders over &#36;50 automatically qualify for complimentary tracked delivery.</p>
                        </div>
                        <div class="rounded-2xl border border-neutral-200 bg-neutral-50 p-6 space-y-3" role="group" aria-label="Extended warranty">
                            <h2 class="text-sm font-semibold text-neutral-700 uppercase tracking-wide">Extended warranty</h2>
                            <p class="text-sm text-neutral-600">Every device ships with a minimum two-year warranty and optional care plans.</p>
                        </div>
                    </div>
                </div>

                <aside class="rounded-2xl border border-brand-primary-200 bg-brand-primary-900 text-white shadow-sm p-8 space-y-6" aria-label="Account guidance">
                    <div class="inline-flex h-12 w-12 items-center justify-center rounded-full bg-white/10" aria-hidden="true">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                        </svg>
                    </div>
                    <div class="space-y-2">
                        <h2 class="text-xl font-semibold">${highlightTitle}</h2>
                        <p class="text-sm text-white/80">${highlightDetail}</p>
                    </div>
                    <div class="space-y-3 text-sm text-white/70">
                        <div class="flex items-start gap-2">
                            <span class="inline-flex h-2 w-2 translate-y-2 rounded-full bg-white"></span>
                            <p>Track orders, manage licences, and access procurement-ready documentation.</p>
                        </div>
                        <div class="flex items-start gap-2">
                            <span class="inline-flex h-2 w-2 translate-y-2 rounded-full bg-white"></span>
                            <p>Invite teammates to collaborate on carts and compatibility reviews.</p>
                        </div>
                        <div class="flex items-start gap-2">
                            <span class="inline-flex h-2 w-2 translate-y-2 rounded-full bg-white"></span>
                            <p>Receive alerts when stock levels change for saved products.</p>
                        </div>
                    </div>
                    <a href="${highlightLinkHref}" class="btn btn--white btn--sm w-full" aria-label="${highlightLinkLabel}">
                        ${highlightLinkLabel}
                    </a>
                </aside>
            </div>

            <section class="space-y-8">
                <header class="space-y-3">
                    <h2 class="text-display-s font-semibold text-neutral-900">Why teams choose IoT Bay</h2>
                    <p class="text-neutral-600 max-w-3xl">Human-centred tooling, global partner hardware, and compliance-first operations keep your deployments moving without surprises.</p>
                </header>
                <ul class="grid gap-4 lg:grid-cols-4 md:grid-cols-2" role="list">
                    <li class="rounded-2xl border border-neutral-200 bg-white p-6 space-y-3" role="group" aria-label="Compatibility assistance">
                        <span class="inline-flex h-8 w-8 items-center justify-center rounded-full bg-brand-primary-100 text-brand-primary">1</span>
                        <h3 class="text-base font-semibold text-neutral-900">Compatibility assistance</h3>
                        <p class="text-sm text-neutral-600">Guided specification reviews ensure sensors, gateways, and middleware integrate cleanly.</p>
                    </li>
                    <li class="rounded-2xl border border-neutral-200 bg-white p-6 space-y-3" role="group" aria-label="Industrial readiness">
                        <span class="inline-flex h-8 w-8 items-center justify-center rounded-full bg-brand-primary-100 text-brand-primary">2</span>
                        <h3 class="text-base font-semibold text-neutral-900">Industrial readiness</h3>
                        <p class="text-sm text-neutral-600">Certified hardware spans harsh environments, on-prem connectivity, and hybrid cloud workloads.</p>
                    </li>
                    <li class="rounded-2xl border border-neutral-200 bg-white p-6 space-y-3" role="group" aria-label="Procurement friendly">
                        <span class="inline-flex h-8 w-8 items-center justify-center rounded-full bg-brand-primary-100 text-brand-primary">3</span>
                        <h3 class="text-base font-semibold text-neutral-900">Procurement friendly</h3>
                        <p class="text-sm text-neutral-600">Quotes, invoices, and compliance documentation stay audit-ready for regulated industries.</p>
                    </li>
                    <li class="rounded-2xl border border-neutral-200 bg-white p-6 space-y-3" role="group" aria-label="Specialist support">
                        <span class="inline-flex h-8 w-8 items-center justify-center rounded-full bg-brand-primary-100 text-brand-primary">4</span>
                        <h3 class="text-base font-semibold text-neutral-900">Specialist support</h3>
                        <p class="text-sm text-neutral-600">Dedicated solution engineers help with pilots, scale-outs, and lifecycle management.</p>
                    </li>
                </ul>
            </section>

            <section class="space-y-6">
                <header class="space-y-2">
                    <h2 class="text-display-s font-semibold text-neutral-900">Quick links</h2>
                    <p class="text-neutral-600">Jump straight into the most common actions for new and returning members.</p>
                </header>
                <div class="grid gap-4 md:grid-cols-3">
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 space-y-3" role="group" aria-label="Browse catalogue">
                        <div class="inline-flex h-10 w-10 items-center justify-center rounded-full bg-brand-primary-100 text-brand-primary" aria-hidden="true">
                            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"></path>
                            </svg>
                        </div>
                        <h3 class="text-base font-semibold text-neutral-900">Browse catalogue</h3>
                        <p class="text-sm text-neutral-600">Filter by protocol, environment rating, or deployment stage to find the right components.</p>
                        <a href="${primaryCtaHref}" class="text-sm font-semibold text-brand-primary hover:underline">Open catalogue</a>
                    </article>
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 space-y-3" role="group" aria-label="Manage profile">
                        <div class="inline-flex h-10 w-10 items-center justify-center rounded-full bg-brand-secondary-100 text-brand-secondary" aria-hidden="true">
                            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"></path>
                            </svg>
                        </div>
                        <h3 class="text-base font-semibold text-neutral-900">Manage profile</h3>
                        <p class="text-sm text-neutral-600">Update organisation details, shipping addresses, and multi-user access in seconds.</p>
                        <a href="${secondaryCtaHref}" class="text-sm font-semibold text-brand-primary hover:underline">Review settings</a>
                    </article>
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 space-y-3" role="group" aria-label="Get expert help">
                        <div class="inline-flex h-10 w-10 items-center justify-center rounded-full bg-neutral-900 text-white" aria-hidden="true">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636l-.707.707A6 6 0 1012 18a6 6 0 006-6h2a8 8 0 11-2.343-5.657l.707.707z" />
                            </svg>
                        </div>
                        <h3 class="text-base font-semibold text-neutral-900">Get expert help</h3>
                        <p class="text-sm text-neutral-600">Need tailored procurement or a custom architecture review? We’ll pair you with a specialist.</p>
                        <a href="${contextPath}/contact.jsp" class="text-sm font-semibold text-brand-primary hover:underline">Contact support</a>
                    </article>
                </div>
            </section>
        </div>
    </section>
</t:base>
