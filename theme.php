<?php

/**
 * This file is part of O3-Shop.
 *
 * O3-Shop is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3.
 *
 * O3-Shop is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with O3-Shop.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @copyright  Copyright (c) 2022 OXID eSales AG (https://www.oxid-esales.com)
 * @copyright  Copyright (c) 2022 O3-Shop (https://www.o3-shop.com)
 * @license    https://www.gnu.org/licenses/gpl-3.0  GNU General Public License 3 (GPLv3)
 */

/**
 * Theme Information
 */
$aTheme = [
    'id'          => 'o3-theme',
    'title'       => 'O3-Theme',
    'description' => 'O3-Theme is O3-Shops official responsive theme based on the CSS framework Bootstrap 5.',
    'thumbnail'   => 'theme.png',
    'version'     => '1.3.4',
    'author'      => '<a href="https://www.o3-shop.com" title="O3-Shop">O3-Shop</a>',
    'settings'    => [
        [
            'group' => 'mode',
            'name'  => 'sShowMode',
            'type'  => 'bool',
            'value' => 0,
        ],
        [
            'group' => 'mode',
            'name'  => 'sShowModePosition',
            'type'        => 'select',
            'value'       => 'topleft',
            'constraints' => 'topleft|topright|bottomleft|bottomright',
        ],
        [
            'group' => 'images',
            'name'  => 'aDetailImageSizes',
            'type'  => 'aarr',
            'value' => [
                'oxpic1'  => '752*633',
                'oxpic2'  => '752*633',
                'oxpic3'  => '752*633',
                'oxpic4'  => '752*633',
                'oxpic5'  => '752*633',
                'oxpic6'  => '752*633',
                'oxpic7'  => '752*633',
                'oxpic8'  => '752*633',
                'oxpic9'  => '752*633',
                'oxpic10' => '752*633',
                'oxpic11' => '752*633',
                'oxpic12' => '752*633',
            ],
        ],
        [
            'group' => 'colors',
            'name'  => 'blPrimaryColor',
            'type'  => 'str',
            'value' => '#82BA00',
        ],
        [
            'group' => 'colors',
            'name'  => 'blSecondaryColor',
            'type'  => 'str',
            'value' => '#F2F8E6',
        ],
        [
            'group' => 'colors',
            'name'  => 'blFooterColor',
            'type'  => 'str',
            'value' => '#F4F8F9',
        ],
        [
            'group' => 'display',
            'name'  => 'aNrofCatArticles',
            'type'  => 'arr',
            'value' => ['10', '20', '50', '100'],
        ],
        [
            'group' => 'display',
            'name'  => 'aNrofCatArticlesInGrid',
            'type'  => 'arr',
            'value' => ['12', '16', '24', '32'],
        ],
        [
            'group' => 'display',
            'name'  => 'bl_showManufacturer',
            'type'  => 'bool',
            'value' => 1,
        ],
        [
            'group' => 'features',
            'name'  => 'bl_showVouchers',
            'type'  => 'bool',
            'value' => 1,
        ],
        [
            'group' => 'emails',
            'name'  => 'blEmailsShowProductPictures',
            'type'  => 'bool',
            'value' => 0,
        ],
        [
            'group' => 'footer',
            'name'  => 'blFooterShowHelp',
            'type'  => 'bool',
            'value' => 1,
        ],
        [
            'group' => 'footer',
            'name'  => 'blFooterShowNewsletter',
            'type'  => 'bool',
            'value' => 1,
        ],
        [
            'group' => 'display',
            'name'  => 'blHomeLink',
            'type'  => 'bool',
            'value' => 0,
        ],
        [
            'group' => 'googleanalytics',
            'name'  => 'blGAAnonymizeIPs',
            'type'  => 'bool',
            'value' => 1,
        ],
        [
            'group' => 'display',
            'name'  => 'blShowBirthdayFields',
            'type'  => 'bool',
            'value' => 0,
        ],
        [
            'group' => 'display',
            'name'  => 'blShowFilters',
            'type'  => 'bool',
            'value' => 1,
        ],
        [
            'group' => 'display',
            'name'  => 'blShowFiltersSearch',
            'type'  => 'str',
            'value' => 10,
        ],
        [
            'group' => 'googleanalytics',
            'name'  => 'blUseGAEcommerceTracking',
            'type'  => 'bool',
            'value' => 1,
        ],
        [
            'group' => 'googleanalytics',
            'name'  => 'blUseGAPageTracker',
            'type'  => 'bool',
            'value' => 1,
        ],
        [
            'group' => 'googlets',
            'name'  => 'blUseGoogleTS',
            'type'  => 'bool',
            'value' => 0,
        ],
        [
            'group' => 'footer',
            'name'  => 'sInstagramUrl',
            'type'  => 'str',
            'value' => 'https://instagram.com',
        ],
        [
            'group' => 'images',
            'name'  => 'sCatIconsize',
            'type'  => 'str',
            'value' => '168*100',
        ],
        [
            'group' => 'images',
            'name'  => 'sCatPromotionsize',
            'type'  => 'str',
            'value' => '370*107',
        ],
        [
            'group' => 'images',
            'name'  => 'sCatThumbnailsize',
            'type'  => 'str',
            'value' => '1296*500',
        ],
        [
            'group'       => 'display',
            'name'        => 'sDefaultListDisplayType',
            'type'        => 'select',
            'value'       => 'grid',
            'constraints' => 'grid|line',
        ],
        [
            'group' => 'slider',
            'name'  => 'sSliderSlideFade',
            'type'        => 'select',
            'value'       => 'fade',
            'constraints' => 'slide|fade',
        ],
        [
            'group' => 'slider',
            'name'  => 'sSliderAutostart',
            'type'        => 'select',
            'value'       => 'on',
            'constraints' => 'on|off',
        ],
        [
            'group' => 'slider',
            'name'  => 'sSliderInterval',
            'type'  => 'str',
            'value' => '5000',
        ],
        [
            'group' => 'slider',
            'name'  => 'sSliderSpeed',
            'type'  => 'str',
            'value' => '400',
        ],
        [
            'group' => 'Jquery',
            'name'  => 'activateJquery',
            'type'  => 'bool',
            'value' => 0,
        ],
        [
            'group' => 'googlets',
            'name'  => 'sDeliveryDaysNotOnStock',
            'type'  => 'str',
            'value' => '14',
        ],
        [
            'group' => 'googlets',
            'name'  => 'sDeliveryDaysOnStock',
            'type'  => 'str',
            'value' => '6',
        ],
        [
            'group' => 'logo',
            'name'  => 'sEmailLogo',
            'type'  => 'str',
            'value' => 'logo_email.png',
        ],
        [
            'group' => 'footer',
            'name'  => 'sFacebookUrl',
            'type'  => 'str',
            'value' => 'https://www.facebook.com',
        ],
        [
            'group' => 'favicons',
            'name'  => 'sFaviconIcoFile',
            'type'  => 'str',
            'value' => 'favicon.ico',
        ],
        [
            'group' => 'favicons',
            'name'  => 'sFaviconSvgFile',
            'type'  => 'str',
            'value' => 'icon.svg',
        ],
        [
            'group' => 'favicons',
            'name'  => 'sFaviconAppleFile',
            'type'  => 'str',
            'value' => 'apple-touch-icon.png',
        ],
        [
            'group' => 'favicons',
            'name'  => 'sFavicon192PngFile',
            'type'  => 'str',
            'value' => 'icon-192.png',
        ],
        [
            'group' => 'favicons',
            'name'  => 'sFavicon512PngFile',
            'type'  => 'str',
            'value' => 'icon-512.png',
        ],
        [
            'group' => 'googleanalytics',
            'name'  => 'sGATrackingId',
            'type'  => 'str',
            'value' => '',
        ],
        [
            'group' => 'contact',
            'name'  => 'sGoogleMapsAddr',
            'type'  => 'str',
            'value' => 'O3-Shop, Musterstraße 17, 12345 Musterstadt',
        ],
        [
            'group' => 'googlets',
            'name'  => 'sGoogleShoppingAccountId',
            'type'  => 'str',
            'value' => '',
        ],
        [
            'group' => 'googlets',
            'name'  => 'sGoogleVendorId',
            'type'  => 'str',
            'value' => '',
        ],
        [
            'group' => 'images',
            'name'  => 'sIconsize',
            'type'  => 'str',
            'value' => '114*114',
        ],
        [
            'group' => 'logo',
            'name'  => 'sLogoFile',
            'type'  => 'str',
            'value' => 'logo_o3.png',
        ],
        [
            'group' => 'images',
            'name'  => 'sManufacturerIconsize',
            'type'  => 'str',
            'value' => '100*100',
        ],
        [
            'group' => 'googlets',
            'name'  => 'sPageLanguage',
            'type'  => 'str',
            'value' => 'de_DE',
        ],
        [
            'group' => 'googlets',
            'name'  => 'sShippingDaysNotOnStock',
            'type'  => 'str',
            'value' => '5',
        ],
        [
            'group' => 'googlets',
            'name'  => 'sShippingDaysOnStock',
            'type'  => 'str',
            'value' => '3',
        ],
        [
            'group' => 'googlets',
            'name'  => 'sShoppingCountry',
            'type'  => 'str',
            'value' => 'DE',
        ],
        [
            'group' => 'googlets',
            'name'  => 'sShoppingLanguage',
            'type'  => 'str',
            'value' => 'de',
        ],
        [
            'group' => 'images',
            'name'  => 'sThumbnailsize',
            'type'  => 'str',
            'value' => '412*240',
        ],
        [
            'group' => 'footer',
            'name'  => 'sTwitterUrl',
            'type'  => 'str',
            'value' => 'https://twitter.com',
        ],
        [
            'group' => 'footer',
            'name'  => 'sYouTubeUrl',
            'type'  => 'str',
            'value' => 'https://www.youtube.com',
        ],
        [
            'group' => 'images',
            'name'  => 'sZoomImageSize',
            'type'  => 'str',
            'value' => '665*665',
        ],
        [
            'group' => 'form',
            'name'  => 'iPasswordLength',
            'type'  => 'str',
            'value' => '10',
        ],
        [
            'group' => 'form',
            'name'  => 'bInputCompany',
            'type'  => 'bool',
            'value' => 'false',
        ],
        [
            'group' => 'form',
            'name'  => 'bInputUstid',
            'type'  => 'bool',
            'value' => 'false',
        ],
        [
            'group' => 'form',
            'name'  => 'bInputState',
            'type'  => 'bool',
            'value' => 'false',
        ],
        [
            'group' => 'form',
            'name'  => 'bInputFax',
            'type'  => 'bool',
            'value' => 'false',
        ],
        [
            'group' => 'form',
            'name'  => 'bInputMobilePhone',
            'type'  => 'bool',
            'value' => 'false',
        ],
        [
            'group' => 'form',
            'name'  => 'bInputPrivatPhone',
            'type'  => 'bool',
            'value' => 'false',
        ],
    ],
];
