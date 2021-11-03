<?php

// main grid nosidebar class // main grid order classes
return [
    //no sidebar
    'supportticketsubmit-stepone'                  => ['main-grid-nosidebar'],
    'supportticketsubmit-steptwo'                  => ['main-grid-nosidebar'],
    'supportticketsubmit-confirm'                  => ['main-grid-nosidebar'],
    
    //order
    'configureproduct'                             => [false, 'main-grid-order '],
    'configureproductdomain'                       => [false, 'main-grid-order main-grid-order-domain'],
    'viewcart'                                     => [false, 'main-grid-order '],
    'checkout'                                     => [false, 'main-grid-order '],
    'upgradesummary'                               => [false, 'main-grid-order '],
    'complete'                                     => [false, 'main-grid-order main-grid-order-domain'],
    'creditcard'                                   => [false, 'main-grid-order '],
    'error'                                        => [false, 'main-grid-order main-grid-order-domain'],
    'invoice-payment'                              => [false, 'main-grid-order '],
];