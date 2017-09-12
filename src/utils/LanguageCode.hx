package utils;

class LanguageCode {

    public static function getLanguageName (countryCode) {

		var isoCountries = {
			'AF' : 'Afrikanns',
            'SQ' : 'Albanian',
            'AR' : 'Arabic',
            'HY' : 'Armenian',
            'EU' : 'Basque',
            'BN' : 'Bengali',
            'BG' : 'Bulgarian',
            'CA' : 'Catalan',
            'KM' : 'Cambodian',
            'ZH' : 'Chinese (Mandarin)',
            'HR' : 'Croation',
            'CS' : 'Czech',
            'DA' : 'Danish',
            'NL' : 'Dutch',
            'EN' : 'English',
            'ET' : 'Estonian',
            'FJ' : 'Fiji',
            'FI' : 'Finnish',
            'FR' : 'French',
            'KA' : 'Georgian',
            'DE' : 'German',
            'EL' : 'Greek',
            'GU' : 'Gujarati',
            'HE' : 'Hebrew',
            'HI' : 'Hindi',
            'HU' : 'Hungarian',
            'IS' : 'Icelandic',
            'ID' : 'Indonesian',
            'GA' : 'Irish',
            'IT' : 'Italian',
            'JA' : 'Japanese',
            'JW' : 'Javanese',
            'KO' : 'Korean',
            'LA' : 'Latin',
            'LV' : 'Latvian',
            'LT' : 'Lithuanian',
            'MK' : 'Macedonian',
            'MS' : 'Malay',
            'ML' : 'Malayalam',
            'MT' : 'Maltese',
            'MI' : 'Maori',
            'MR' : 'Marathi',
            'MN' : 'Mongolian',
            'NE' : 'Nepali',
            'NO' : 'Norwegian',
            'FA' : 'Persian',
            'PL' : 'Polish',
            'PT' : 'Portuguese',
            'PA' : 'Punjabi',
            'QU' : 'Quechua',
            'RO' : 'Romanian',
            'RU' : 'Russian',
            'SM' : 'Samoan',
            'SR' : 'Serbian',
            'SK' : 'Slovak',
            'SL' : 'Slovenian',
            'ES' : 'Spanish',
            'SW' : 'Swahili',
            'SV' : 'Swedish ',
            'TA' : 'Tamil',
            'TT' : 'Tatar',
            'TE' : 'Telugu',
            'TH' : 'Thai',
            'BO' : 'Tibetan',
            'TO' : 'Tonga',
            'TR' : 'Turkish',
            'UK' : 'Ukranian',
            'UR' : 'Urdu',
            'UZ' : 'Uzbek',
            'VI' : 'Vietnamese',
            'CY' : 'Welsh',
            'XH' : 'Xhosa'
		};

        if (Reflect.hasField(isoCountries,countryCode)) {
            return Reflect.getProperty(isoCountries,countryCode);
        } else {
            return countryCode;
        }
    }

}