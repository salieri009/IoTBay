<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<t:base title="Returns & Refunds - IoT Bay" description="Return policy and refund information for IoT Bay products">
    <main class="py-12">
        <div class="container space-y-12">
            <!-- Hero Section -->
            <section class="text-center space-y-6">
                <p class="inline-flex items-center justify-center gap-2 text-xs font-semibold uppercase tracking-wide text-neutral-500">
                    <span class="inline-flex h-2 w-2 rounded-full bg-brand-primary"></span>
                    Hassle-free returns
                </p>
                <h1 class="text-display-xl font-extrabold text-neutral-900 leading-tight">
                    Returns & Refunds
                </h1>
                <p class="text-lg md:text-xl text-neutral-600 max-w-2xl mx-auto">
                    We stand behind our products. If you're not satisfied, we'll make it right with our straightforward return and refund policy.
                </p>
            </section>

            <!-- Return Policy -->
            <section class="space-y-8">
                <h2 class="text-display-m font-bold text-neutral-900">Return Policy</h2>
                
                <div class="grid gap-6 md:grid-cols-2">
                    <!-- Return Window -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-4">30-Day Return Window</h3>
                        <p class="text-neutral-600 text-sm leading-relaxed mb-4">
                            You have 30 days from the date of delivery to return any item for a full refund or exchange. The item must be in its original condition with all packaging and accessories included.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-600">
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>Original packaging required</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>All accessories must be included</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>Item must be unused and in original condition</span>
                            </li>
                        </ul>
                    </article>

                    <!-- Return Process -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-4">How to Return</h3>
                        <ol class="space-y-3 text-sm text-neutral-600 list-decimal list-inside">
                            <li>Log into your account and go to Order History</li>
                            <li>Select the order containing the item you want to return</li>
                            <li>Click "Return Item" and select the reason for return</li>
                            <li>Print the prepaid return shipping label</li>
                            <li>Package the item securely and attach the label</li>
                            <li>Drop off at any authorized shipping location</li>
                        </ol>
                    </article>

                    <!-- Refund Processing -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-4">Refund Processing</h3>
                        <p class="text-neutral-600 text-sm leading-relaxed mb-4">
                            Once we receive and inspect your returned item, we'll process your refund within 5-7 business days. Refunds will be issued to the original payment method.
                        </p>
                        <dl class="space-y-2 text-sm">
                            <div>
                                <dt class="font-medium text-neutral-700">Processing Time</dt>
                                <dd class="text-neutral-600">5-7 business days after receipt</dd>
                            </div>
                            <div>
                                <dt class="font-medium text-neutral-700">Refund Method</dt>
                                <dd class="text-neutral-600">Original payment method</dd>
                            </div>
                            <div>
                                <dt class="font-medium text-neutral-700">Shipping Costs</dt>
                                <dd class="text-neutral-600">Refunded for defective items only</dd>
                            </div>
                        </dl>
                    </article>

                    <!-- Exceptions -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-4">Non-Returnable Items</h3>
                        <p class="text-neutral-600 text-sm leading-relaxed mb-4">
                            Some items cannot be returned for hygiene or safety reasons. Custom orders and personalized items are also non-returnable.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-600">
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>Opened software or digital products</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>Custom or personalized items</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>Items damaged by misuse</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>Items returned after 30 days</span>
                            </li>
                        </ul>
                    </article>
                </div>
            </section>

            <!-- Defective Items -->
            <section class="rounded-2xl border border-brand-secondary bg-brand-secondary/5 p-8">
                <h2 class="text-display-m font-bold text-neutral-900 mb-4">Defective or Damaged Items</h2>
                <p class="text-neutral-600 mb-6 max-w-3xl">
                    If you receive a defective or damaged item, please contact us immediately. We'll send a replacement at no cost and provide a prepaid return label for the defective item. You may also be eligible for expedited shipping on your replacement order.
                </p>
                <a href="${pageContext.request.contextPath}/contact" class="btn btn--primary">
                    Report Defective Item
                </a>
            </section>

            <!-- Exchange Policy -->
            <section class="space-y-8">
                <h2 class="text-display-m font-bold text-neutral-900">Exchanges</h2>
                
                <div class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                    <p class="text-neutral-600 text-sm leading-relaxed mb-4">
                        We're happy to exchange items for a different size, color, or model. Exchanges follow the same 30-day return window and condition requirements. If the exchange item costs more, you'll pay the difference. If it costs less, we'll refund the difference.
                    </p>
                    <p class="text-neutral-600 text-sm">
                        To initiate an exchange, follow the return process and specify that you'd like an exchange instead of a refund. Our team will contact you to confirm the exchange item.
                    </p>
                </div>
            </section>
        </div>
    </main>
</t:base>

