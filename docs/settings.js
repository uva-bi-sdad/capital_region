const site = {
  "settings": {
    "digits": 2,
    "summary_selection": "all",
    "color_by_order": false,
    "boxplots": true,
    "theme_dark": false,
    "partial_init": true,
    "palette": "rdylbu7",
    "hide_url_parameters": false,
    "background_shapes": true
  },
  "metadata": {
    "package": "data/datapackage.json",
    "datasets": ["county", "tract", "block_group"],
    "variables": ["time", "dei:norm_dei", "speed_measurements:avg_down_using_devices", "speed_measurements:devices", "speed_measurements:avg_up_using_devices", "percent_above_threshold:perc_w_int_25_3_using_devices", "percent_above_threshold:perc_w_int_100_20_using_devices", "percent_above_threshold:perc_total_25_3_using_devices", "percent_above_threshold:perc_total_100_20_using_devices"],
    "info": {
      "block_group": {
        "bytes": 5618614,
        "encoding": "ISO-8859-1",
        "md5": "13380fc4bee9c580e6b12f62ec96290f",
        "sha512": "f23ac502116da739d770c03bc079f73bba342095994d8770ebf93c22ad0331e22997f998c81d3ca250b5de210b887af3f69106b0f4beb13634f7a90fb72a5682",
        "format": "csv",
        "name": "block_group",
        "filename": "block_group.csv",
        "source": [],
        "ids": [
          {
            "variable": "ID",
            "map": "data/entity_info.json"
          }
        ],
        "time": "time",
        "profile": "data-resource",
        "created": "2022-01-13 00:03:30",
        "last_modified": "2022-01-06 16:35:05",
        "rowcount": 9735,
        "schema": {
          "fields": [
            {
              "name": "time",
              "duplicates": 9732,
              "info": {
                "type": "year",
                "short_name": "Year",
                "full_name": "time"
              },
              "type": "integer",
              "missing": 0,
              "mean": 2020,
              "sd": 0.8165,
              "min": 2019,
              "max": 2021
            },
            {
              "name": "dei:norm_dei",
              "duplicates": 57,
              "info": {
                "category": "Broadband",
                "short_name": "Digital Equity Index",
                "long_name": "Digital Equity Index",
                "description": "The Digital Equity Index (DEI) is a composite variable indicating the degree of broadband equity as it relates to adoption, accessibility, and infrastructure. It ranges from 0 to 100, where 100 indicates the most equitable broadband access. The DEI is constructed at the Census tract level and is composed of the following variables: percent of the population under 65 years of age, percent of the population with at least a high school education, percent of the population with income below the poverty level, percent of the population without a disability, the ratio between the share of homes making $75,000 or more per year with internet and the share of homes making less than $35,000 per year without internet, percent of the population with at least one computer, percent of the population with internet access, percent of the population that is low income (less than 30% of HUD Area Median Family Income) and have a housing cost burden over 30%, and average download speeds, upload speeds, and latency from Ookla speed tests.",
                "statement": "The digital equity index for {features.name} is {value}.",
                "type": "index",
                "source": [
                  {
                    "name": "American Community Survey",
                    "date_accessed": 2021,
                    "url": "https://www.census.gov/programs-surveys/acs.html"
                  },
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 54,
              "mean": 28.8048,
              "sd": 5.8144,
              "min": 0,
              "max": 100
            },
            {
              "name": "speed_measurements:avg_down_using_devices",
              "duplicates": 11,
              "info": {
                "category": "Broadband",
                "short_name": "Average Download Speed",
                "long_name": "Average Download Speed",
                "description": "Average download speed weighted by number of devices.",
                "statement": "The average download speed is {value} MB/s in {features.name}.",
                "type": "average",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 3,
              "mean": 166.011,
              "sd": 40.5184,
              "min": 6.1529,
              "max": 421.6348
            },
            {
              "name": "speed_measurements:devices",
              "duplicates": 2,
              "info": {
                "category": "Broadband",
                "short_name": "Number of devices",
                "long_name": "Number of devices",
                "description": "The number of unique devices accessing Ookla Internet speed tests.",
                "statement": "There are {value} unique devices in {features.name} accessing Ookla Internet speed tests.",
                "type": "count",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 3,
              "mean": 109.2705,
              "sd": 103.2507,
              "min": 0.8573,
              "max": 1898.2632
            },
            {
              "name": "speed_measurements:avg_up_using_devices",
              "duplicates": 11,
              "info": {
                "category": "Broadband",
                "short_name": "Average Upload Speed",
                "long_name": "Average Upload Speed",
                "description": "Average upload speed weighted by number of devices.",
                "statement": "The average upload speed is {value} MB/s in {features.name}.",
                "type": "average",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 3,
              "mean": 84.7144,
              "sd": 37.6663,
              "min": 0.5799,
              "max": 243.3146
            },
            {
              "name": "percent_above_threshold:perc_w_int_25_3_using_devices",
              "duplicates": 11,
              "info": {
                "category": "Broadband",
                "short_name": "Percent Good (internet-connected)",
                "long_name": "Percent of the Internet-Connected Population with Good Internet Speed",
                "description": "Percent of the internet-connected population with a good internet speed (above 25/3 MB/s, able to stream video or online game for one device).",
                "statement": "{value} percent of the internet-connected population in {features.name} has a good internet speed.",
                "type": "percent",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 3,
              "mean": 96.2065,
              "sd": 7.246,
              "min": 30.3525,
              "max": 100
            },
            {
              "name": "percent_above_threshold:perc_w_int_100_20_using_devices",
              "duplicates": 11,
              "info": {
                "category": "Broadband",
                "short_name": "Percent Fast (internet-connected)",
                "long_name": "Percent of the Internet-Connected Population with Fast Internet Speed",
                "description": "Percent of the internet-connected population with a fast internet speed (above 100/20 MB/s, able to stream HD video on multiple devices or download large files quickly).",
                "statement": "{value} percent of the internet-connected population in {features.name} has a fast internet speed.",
                "type": "percent",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 3,
              "mean": 79.1085,
              "sd": 23.6007,
              "min": 0.0649,
              "max": 99.9998
            },
            {
              "name": "percent_above_threshold:perc_total_25_3_using_devices",
              "duplicates": 41,
              "info": {
                "category": "Broadband",
                "short_name": "Percent Good (total)",
                "long_name": "Percent of the Total Population with Good Internet Speed",
                "description": "Percent of the total population with a good internet speed (above 25/3 MB/s, able to stream video or online game for one device).",
                "statement": "{value} percent of the total population in {features.name} has a good internet speed.",
                "type": "percent",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 42,
              "mean": 89.1016,
              "sd": 12.058,
              "min": 18.8037,
              "max": 100
            },
            {
              "name": "percent_above_threshold:perc_total_100_20_using_devices",
              "duplicates": 41,
              "info": {
                "category": "Broadband",
                "short_name": "Percent Fast (total)",
                "long_name": "Percent of the Total Population with Fast Internet Speed",
                "description": "Percent of the total population with a fast internet speed (above 100/20 MB/s, able to stream HD video on multiple devices or download large files quickly).",
                "statement": "{value} percent of the total population in {features.name} has a fast internet speed.",
                "type": "percent",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 42,
              "mean": 73.5334,
              "sd": 23.8119,
              "min": 0.0504,
              "max": 99.9989
            }
          ]
        },
        "site_file": "block_group.json"
      },
      "tract": {
        "bytes": 2202094,
        "encoding": "ISO-8859-1",
        "md5": "5d3588a166d2283050beb3b6b5ddd749",
        "sha512": "8cc3a5ab597b1228ffa629fdc2eeedd86db85abec76883c442118cf04e78cfa13ad0f37f4920a66e4eef72e25857927c368516392e27282bf99743463a890194",
        "format": "csv",
        "name": "tract",
        "filename": "tract.csv",
        "source": [],
        "ids": [
          {
            "variable": "ID",
            "map": "data/entity_info.json"
          }
        ],
        "time": "time",
        "profile": "data-resource",
        "created": "2022-01-13 00:03:31",
        "last_modified": "2022-01-06 16:35:06",
        "rowcount": 3672,
        "schema": {
          "fields": [
            {
              "name": "time",
              "duplicates": 3669,
              "info": {
                "type": "year",
                "short_name": "Year",
                "full_name": "time"
              },
              "type": "integer",
              "missing": 0,
              "mean": 2020,
              "sd": 0.8166,
              "min": 2019,
              "max": 2021
            },
            {
              "name": "dei:norm_dei",
              "duplicates": 33,
              "info": {
                "category": "Broadband",
                "short_name": "Digital Equity Index",
                "long_name": "Digital Equity Index",
                "description": "The Digital Equity Index (DEI) is a composite variable indicating the degree of broadband equity as it relates to adoption, accessibility, and infrastructure. It ranges from 0 to 100, where 100 indicates the most equitable broadband access. The DEI is constructed at the Census tract level and is composed of the following variables: percent of the population under 65 years of age, percent of the population with at least a high school education, percent of the population with income below the poverty level, percent of the population without a disability, the ratio between the share of homes making $75,000 or more per year with internet and the share of homes making less than $35,000 per year without internet, percent of the population with at least one computer, percent of the population with internet access, percent of the population that is low income (less than 30% of HUD Area Median Family Income) and have a housing cost burden over 30%, and average download speeds, upload speeds, and latency from Ookla speed tests.",
                "statement": "The digital equity index for {features.name} is {value}.",
                "type": "index",
                "source": [
                  {
                    "name": "American Community Survey",
                    "date_accessed": 2021,
                    "url": "https://www.census.gov/programs-surveys/acs.html"
                  },
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 30,
              "mean": 34.5123,
              "sd": 7.7519,
              "min": 0,
              "max": 100
            },
            {
              "name": "speed_measurements:avg_down_using_devices",
              "duplicates": 0,
              "info": {
                "category": "Broadband",
                "short_name": "Average Download Speed",
                "long_name": "Average Download Speed",
                "description": "Average download speed weighted by number of devices.",
                "statement": "The average download speed is {value} MB/s in {features.name}.",
                "type": "average",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 0,
              "mean": 166.2192,
              "sd": 36.3973,
              "min": 41.1974,
              "max": 299.7787
            },
            {
              "name": "speed_measurements:devices",
              "duplicates": 0,
              "info": {
                "category": "Broadband",
                "short_name": "Number of devices",
                "long_name": "Number of devices",
                "description": "The number of unique devices accessing Ookla Internet speed tests.",
                "statement": "There are {value} unique devices in {features.name} accessing Ookla Internet speed tests.",
                "type": "count",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 0,
              "mean": 289.6025,
              "sd": 245.5175,
              "min": 7.54,
              "max": 4526.3565
            },
            {
              "name": "speed_measurements:avg_up_using_devices",
              "duplicates": 0,
              "info": {
                "category": "Broadband",
                "short_name": "Average Upload Speed",
                "long_name": "Average Upload Speed",
                "description": "Average upload speed weighted by number of devices.",
                "statement": "The average upload speed is {value} MB/s in {features.name}.",
                "type": "average",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 0,
              "mean": 85.934,
              "sd": 33.7183,
              "min": 9.1951,
              "max": 189.9267
            },
            {
              "name": "percent_above_threshold:perc_w_int_25_3_using_devices",
              "duplicates": 20,
              "info": {
                "category": "Broadband",
                "short_name": "Percent Good (internet-connected)",
                "long_name": "Percent of the Internet-Connected Population with Good Internet Speed",
                "description": "Percent of the internet-connected population with a good internet speed (above 25/3 MB/s, able to stream video or online game for one device).",
                "statement": "{value} percent of the internet-connected population in {features.name} has a good internet speed.",
                "type": "percent",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 21,
              "mean": 0.9625,
              "sd": 0.0634,
              "min": 0.3913,
              "max": 1
            },
            {
              "name": "percent_above_threshold:perc_w_int_100_20_using_devices",
              "duplicates": 20,
              "info": {
                "category": "Broadband",
                "short_name": "Percent Fast (internet-connected)",
                "long_name": "Percent of the Internet-Connected Population with Fast Internet Speed",
                "description": "Percent of the internet-connected population with a fast internet speed (above 100/20 MB/s, able to stream HD video on multiple devices or download large files quickly).",
                "statement": "{value} percent of the internet-connected population in {features.name} has a fast internet speed.",
                "type": "percent",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 21,
              "mean": 0.8011,
              "sd": 0.213,
              "min": 0.0092,
              "max": 1
            },
            {
              "name": "percent_above_threshold:perc_total_25_3_using_devices",
              "duplicates": 20,
              "info": {
                "category": "Broadband",
                "short_name": "Percent Good (total)",
                "long_name": "Percent of the Total Population with Good Internet Speed",
                "description": "Percent of the total population with a good internet speed (above 25/3 MB/s, able to stream video or online game for one device).",
                "statement": "{value} percent of the total population in {features.name} has a good internet speed.",
                "type": "percent",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 21,
              "mean": 0.8894,
              "sd": 0.107,
              "min": 0.2506,
              "max": 1
            },
            {
              "name": "percent_above_threshold:perc_total_100_20_using_devices",
              "duplicates": 20,
              "info": {
                "category": "Broadband",
                "short_name": "Percent Fast (total)",
                "long_name": "Percent of the Total Population with Fast Internet Speed",
                "description": "Percent of the total population with a fast internet speed (above 100/20 MB/s, able to stream HD video on multiple devices or download large files quickly).",
                "statement": "{value} percent of the total population in {features.name} has a fast internet speed.",
                "type": "percent",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 21,
              "mean": 0.7422,
              "sd": 0.2161,
              "min": 0.0079,
              "max": 0.9989
            }
          ]
        },
        "site_file": "tract.json"
      },
      "county": {
        "bytes": 26734,
        "encoding": "ISO-8859-1",
        "md5": "b174fa970813e33030e485249e084d6b",
        "sha512": "03382cf9aac80500d7761557a6cf403900aa6c6c36e11bce6df5993401bd68aa4d7fb233e7172f6506ef2833cfb407b9b59f789f2b98a3959615550efbbbfed6",
        "format": "csv",
        "name": "county",
        "filename": "county.csv",
        "source": [],
        "ids": [
          {
            "variable": "ID",
            "map": "data/entity_info.json"
          }
        ],
        "time": "time",
        "profile": "data-resource",
        "created": "2022-01-13 00:03:31",
        "last_modified": "2022-01-06 16:35:06",
        "rowcount": 42,
        "schema": {
          "fields": [
            {
              "name": "time",
              "duplicates": 39,
              "info": {
                "type": "year",
                "short_name": "Year",
                "full_name": "time"
              },
              "type": "integer",
              "missing": 0,
              "mean": 2020,
              "sd": 0.8264,
              "min": 2019,
              "max": 2021
            },
            {
              "name": "dei:norm_dei",
              "duplicates": 4,
              "info": {
                "category": "Broadband",
                "short_name": "Digital Equity Index",
                "long_name": "Digital Equity Index",
                "description": "The Digital Equity Index (DEI) is a composite variable indicating the degree of broadband equity as it relates to adoption, accessibility, and infrastructure. It ranges from 0 to 100, where 100 indicates the most equitable broadband access. The DEI is constructed at the Census tract level and is composed of the following variables: percent of the population under 65 years of age, percent of the population with at least a high school education, percent of the population with income below the poverty level, percent of the population without a disability, the ratio between the share of homes making $75,000 or more per year with internet and the share of homes making less than $35,000 per year without internet, percent of the population with at least one computer, percent of the population with internet access, percent of the population that is low income (less than 30% of HUD Area Median Family Income) and have a housing cost burden over 30%, and average download speeds, upload speeds, and latency from Ookla speed tests.",
                "statement": "The digital equity index for {features.name} is {value}.",
                "type": "index",
                "source": [
                  {
                    "name": "American Community Survey",
                    "date_accessed": 2021,
                    "url": "https://www.census.gov/programs-surveys/acs.html"
                  },
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 0,
              "mean": 52.796,
              "sd": 24.868,
              "min": 0,
              "max": 100
            },
            {
              "name": "speed_measurements:avg_down_using_devices",
              "duplicates": 0,
              "info": {
                "category": "Broadband",
                "short_name": "Average Download Speed",
                "long_name": "Average Download Speed",
                "description": "Average download speed weighted by number of devices.",
                "statement": "The average download speed is {value} MB/s in {features.name}.",
                "type": "average",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 0,
              "mean": 169.2292,
              "sd": 30.843,
              "min": 124.2579,
              "max": 221.2074
            },
            {
              "name": "speed_measurements:devices",
              "duplicates": 0,
              "info": {
                "category": "Broadband",
                "short_name": "Number of devices",
                "long_name": "Number of devices",
                "description": "The number of unique devices accessing Ookla Internet speed tests.",
                "statement": "There are {value} unique devices in {features.name} accessing Ookla Internet speed tests.",
                "type": "count",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 0,
              "mean": 25319.5333,
              "sd": 26925.8845,
              "min": 581.9006,
              "max": 106499.5253
            },
            {
              "name": "speed_measurements:avg_up_using_devices",
              "duplicates": 0,
              "info": {
                "category": "Broadband",
                "short_name": "Average Upload Speed",
                "long_name": "Average Upload Speed",
                "description": "Average upload speed weighted by number of devices.",
                "statement": "The average upload speed is {value} MB/s in {features.name}.",
                "type": "average",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 0,
              "mean": 86.7467,
              "sd": 31.9136,
              "min": 13.5823,
              "max": 127.8421
            },
            {
              "name": "percent_above_threshold:perc_w_int_25_3_using_devices",
              "duplicates": 0,
              "info": {
                "category": "Broadband",
                "short_name": "Percent Good (internet-connected)",
                "long_name": "Percent of the Internet-Connected Population with Good Internet Speed",
                "description": "Percent of the internet-connected population with a good internet speed (above 25/3 MB/s, able to stream video or online game for one device).",
                "statement": "{value} percent of the internet-connected population in {features.name} has a good internet speed.",
                "type": "percent",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 0,
              "mean": 0.9662,
              "sd": 0.0351,
              "min": 0.8482,
              "max": 1
            },
            {
              "name": "percent_above_threshold:perc_w_int_100_20_using_devices",
              "duplicates": 0,
              "info": {
                "category": "Broadband",
                "short_name": "Percent Fast (internet-connected)",
                "long_name": "Percent of the Internet-Connected Population with Fast Internet Speed",
                "description": "Percent of the internet-connected population with a fast internet speed (above 100/20 MB/s, able to stream HD video on multiple devices or download large files quickly).",
                "statement": "{value} percent of the internet-connected population in {features.name} has a fast internet speed.",
                "type": "percent",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 0,
              "mean": 0.7951,
              "sd": 0.2195,
              "min": 0.1056,
              "max": 0.9944
            },
            {
              "name": "percent_above_threshold:perc_total_25_3_using_devices",
              "duplicates": 0,
              "info": {
                "category": "Broadband",
                "short_name": "Percent Good (total)",
                "long_name": "Percent of the Total Population with Good Internet Speed",
                "description": "Percent of the total population with a good internet speed (above 25/3 MB/s, able to stream video or online game for one device).",
                "statement": "{value} percent of the total population in {features.name} has a good internet speed.",
                "type": "percent",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 0,
              "mean": 0.9012,
              "sd": 0.0549,
              "min": 0.7937,
              "max": 0.973
            },
            {
              "name": "percent_above_threshold:perc_total_100_20_using_devices",
              "duplicates": 0,
              "info": {
                "category": "Broadband",
                "short_name": "Percent Fast (total)",
                "long_name": "Percent of the Total Population with Fast Internet Speed",
                "description": "Percent of the total population with a fast internet speed (above 100/20 MB/s, able to stream HD video on multiple devices or download large files quickly).",
                "statement": "{value} percent of the total population in {features.name} has a fast internet speed.",
                "type": "percent",
                "source": [
                  {
                    "name": "Ookla",
                    "date_accessed": 2021,
                    "url": "https://www.ookla.com/ookla-for-good/open-data"
                  }
                ]
              },
              "type": "float",
              "missing": 0,
              "mean": 0.7429,
              "sd": 0.2114,
              "min": 0.0966,
              "max": 0.96
            }
          ]
        },
        "site_file": "county.json"
      }
    },
    "files": ["county.csv", "tract.csv", "block_group.csv"]
  },
  "rules": [
    {
      "condition": [
        {
          "id": "selected_county",
          "type": "",
          "value": ""
        }
      ],
      "effects": {
        "display": "sec32"
      }
    }
  ],
  "variables": [
    {
      "id": "shapes",
      "states": [
        {
          "condition": [
            {
              "id": "selected_county",
              "type": "",
              "value": ""
            },
            {
              "id": "selected_tract",
              "type": "!",
              "value": ""
            }
          ],
          "value": "tract"
        },
        {
          "condition": [
            {
              "id": "selected_tract",
              "type": "",
              "value": ""
            }
          ],
          "value": "block_group"
        }
      ],
      "default": "county"
    },
    {
      "id": "region_select",
      "states": [
        {
          "condition": [
            {
              "id": "shapes",
              "type": "=",
              "value": "county"
            }
          ],
          "value": "selected_county"
        }
      ],
      "default": "selected_tract"
    },
    {
      "id": "selected_region",
      "states": [
        {
          "condition": [
            {
              "id": "selected_tract",
              "type": "",
              "value": ""
            }
          ],
          "value": "selected_tract"
        }
      ],
      "default": "selected_county"
    }
  ],
  "dataviews": {
    "primary_view": {
      "palette": "",
      "y": "selected_variable",
      "x": "selected_year",
      "time_agg": "selected_year",
      "time_filters": [
        {
          "variable": "time",
          "type": ">=",
          "value": "min_year"
        },
        {
          "variable": "time",
          "type": "<=",
          "value": "max_year"
        }
      ],
      "dataset": "shapes",
      "ids": "selected_region",
      "variables": [
        {
          "variable": "selected_variable",
          "type": "<=",
          "value": "variable_min"
        },
        {
          "variable": "selected_variable",
          "type": ">=",
          "value": "variable_max"
        }
      ]
    }
  },
  "info": {
    "variable_info_pane": {
      "title": "variables.short_name",
      "body": [
        {
          "name": "Year",
          "value": "data.time",
          "style": "table"
        },
        {
          "name": "",
          "value": "variables.source",
          "style": "table"
        }
      ],
      "default": [],
      "floating": false,
      "dataview": "primary_view",
      "variable_info": false
    },
    "info11": {
      "title": "features.name",
      "body": [],
      "default": {
        "title": "National Capital Region",
        "body": "Hover over or select a region for more information."
      },
      "floating": false,
      "dataview": "primary_view",
      "subto": ["main_map", "main_plot"],
      "variable_info": false
    },
    "info12": {
      "title": "",
      "body": [
        {
          "name": "variables.long_name",
          "value": "selected_variable",
          "style": "table"
        },
        {
          "name": "",
          "value": "variables.statement",
          "style": "stack"
        }
      ],
      "default": [],
      "floating": false,
      "dataview": "primary_view",
      "subto": ["main_map", "main_plot"],
      "variable_info": false
    }
  },
  "text": {
    "text7": {
      "text": [
        {
          "button": {
            "b1": {
              "text": [
                "National Capital Region"
              ],
              "type": "reset",
              "target": "selected_county"
            }
          },
          "text": "b1"
        },
        {
          "condition": [
            {
              "id": "selected_county",
              "type": "",
              "value": ""
            }
          ],
          "button": {
            "b1": {
              "text": [
                "",
                "selected_county"
              ],
              "type": "reset",
              "target": "selected_tract"
            }
          },
          "text": [" > ", "b1"]
        },
        {
          "condition": [
            {
              "id": "selected_tract",
              "type": "",
              "value": ""
            }
          ],
          "text": [" > ", "selected_tract"]
        }
      ]
    },
    "text8": {
      "text": [
        [
          {
            "text": "National Capital Region",
            "condition": [
              {
                "id": "default",
                "type": "",
                "value": ""
              }
            ]
          },
          {
            "text": ["selected_county", " Tracts"],
            "condition": [
              {
                "id": "selected_county",
                "type": "",
                "value": ""
              }
            ]
          },
          {
            "text": ["selected_tract", " Block Groups"],
            "condition": [
              {
                "id": "selected_tract",
                "type": "",
                "value": ""
              }
            ]
          }
        ]
      ]
    }
  },
  "select": {
    "selected_variable": {
      "category": "variable_type"
    }
  },
  "tables": {
    "table17": {
      "scrollY": 400,
      "rowGroup": {
        "dataSrc": "features.name"
      },
      "columnDefs": [
        {
          "targets": "features.name",
          "visible": false
        }
      ],
      "buttons": ["copy", "csv", "excel", "print"],
      "dom": "<'row't><'row'<'col-sm'B><'col'f>>",
      "features": [
        {
          "name": "id",
          "title": "ID"
        },
        {
          "name": "name",
          "title": "Name"
        }
      ],
      "filters": {
        "category": "variable_type"
      },
      "single_variable": false,
      "wide": false,
      "paging": false,
      "scrollX": 500,
      "scrollCollapse": true
    },
    "table19": {
      "info": false,
      "searching": false,
      "variables": "selected_variable",
      "single_variable": true,
      "wide": true,
      "paging": false,
      "scrollY": 500,
      "scrollX": 500,
      "scrollCollapse": true
    }
  },
  "plots": {
    "main_plot": {
      "layout": {
        "showlegend": false,
        "xaxis": {
          "title": false,
          "fixedrange": true
        },
        "yaxis": {
          "fixedrange": true,
          "zeroline": false
        },
        "hovermode": "closest",
        "margin": {
          "t": 25,
          "r": 10,
          "b": 40,
          "l": 60
        }
      },
      "config": {
        "modeBarButtonsToRemove": ["select2d", "lasso2d", "sendDataToCloud"],
        "showSendToCloud": false,
        "responsive": true,
        "showTips": false,
        "displaylogo": false,
        "modeBarButtonsToAdd": ["hoverclosest", "hovercompare"]
      },
      "data": [
        {
          "type": "plot_type",
          "hoverinfo": "text",
          "mode": "lines+markers",
          "showlegend": false
        },
        {
          "type": "box",
          "fillcolor": "transparent",
          "hoverinfo": "text",
          "mode": "lines+markers",
          "showlegend": false,
          "name": "Summary"
        }
      ],
      "subto": [
        "main_map"
      ]
    }
  },
  "maps": {
    "main_map": {
      "shapes": [
        {
          "name": "county",
          "url": "https://uva-bi-sdad.github.io/community/dist/shapes/capital_region/counties.geojson",
          "id_property": "GEOID"
        },
        {
          "name": "tract",
          "url": "https://uva-bi-sdad.github.io/community/dist/shapes/capital_region/tracts.geojson",
          "id_property": "GEOID"
        },
        {
          "name": "block_group",
          "url": "https://uva-bi-sdad.github.io/community/dist/shapes/capital_region/blockgroups.geojson",
          "id_property": "GEOID"
        }
      ],
      "options": {
        "attributionControl": false,
        "scrollWheelZoom": false,
        "center": [38.9936, -77.3135],
        "zoom": 8,
        "height": "430px",
        "subto": [
          "main_plot"
        ],
        "background_shapes": "tract"
      },
      "tiles": {
        "light": {
          "url": "https://stamen-tiles-{s}.a.ssl.fastly.net/toner-lite/{z}/{x}/{y}{r}.png"
        },
        "dark": {
          "url": "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png"
        }
      }
    },
    "_raw": []
  },
  "credits": {
    "bootstrap": {
      "name": "Bootstrap",
      "url": "https://getbootstrap.com",
      "version": "5.1.3"
    },
    "leaflet": {
      "name": "Leaflet",
      "url": "https://leafletjs.com",
      "version": "1.7.1",
      "description": "A JS library for interactive maps"
    },
    "Stamen toner-light": {
      "name": "Stamen toner-light",
      "url": "https://stamen.com",
      "description": "Light-theme map tiles by Stamen Design"
    },
    "CARTO Dark Matter": {
      "name": "CARTO Dark Matter",
      "url": "https://carto.com/attributions",
      "description": "Dark-theme map tiles by CARTO"
    },
    "OpenStreetMap": {
      "name": "OpenStreetMap",
      "url": "https://www.openstreetmap.org/copyright"
    },
    "plotly": {
      "name": "Plotly",
      "url": "https://plotly.com",
      "version": "2.8.3"
    },
    "datatables": {
      "name": "DataTables",
      "url": "https://datatables.net",
      "version": "1.11.3"
    }
  }
}
