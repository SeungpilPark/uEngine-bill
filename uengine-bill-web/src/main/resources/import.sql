-- DROP DATABASE iam;
CREATE DATABASE iam
  CHARACTER SET UTF8
  COLLATE UTF8_GENERAL_CI;

DROP USER 'iam'@'localhost';
CREATE USER 'iam'@'localhost'
  IDENTIFIED BY 'iam';
GRANT ALL PRIVILEGES ON *.* TO 'iam'@'localhost';
FLUSH PRIVILEGES;

USE iam;

DROP TABLE IF EXISTS iam.CONTACT_US;

CREATE TABLE IF NOT EXISTS iam.CONTACT_US (
  _id          VARCHAR(255) NOT NULL,
  name         VARCHAR(255) DEFAULT NULL,
  email        VARCHAR(255) DEFAULT NULL,
  telephone    VARCHAR(255) DEFAULT NULL,
  subject      TEXT,
  message      TEXT,
  registration TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (_id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS iam.MANAGEMENT_USER;

CREATE TABLE IF NOT EXISTS iam.MANAGEMENT_USER (
  _id          VARCHAR(255) NOT NULL,
  email        VARCHAR(255)          DEFAULT NULL,
  passwd       VARCHAR(255)          DEFAULT NULL,
  enabled      BOOLEAN      NOT NULL DEFAULT FALSE,
  nm           VARCHAR(255)          DEFAULT NULL,
  description  LONGTEXT,
  authority    VARCHAR(255)          DEFAULT 'ROLE_USER',
  regDate      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updDate      TIMESTAMP    NOT NULL DEFAULT 0,
  level        SMALLINT(6)  NOT NULL DEFAULT '5',
  firstName    VARCHAR(255)          DEFAULT NULL,
  lastName     VARCHAR(255)          DEFAULT NULL,
  organization VARCHAR(255)          DEFAULT NULL,
  officePhone  VARCHAR(255)          DEFAULT NULL,
  country      CHAR(2)               DEFAULT NULL,
  address1     LONGTEXT,
  address2     LONGTEXT,
  city         VARCHAR(255)          DEFAULT NULL,
  state        VARCHAR(255)          DEFAULT NULL,
  zip          VARCHAR(255)          DEFAULT NULL,
  phone        VARCHAR(255)          DEFAULT NULL,
  taxid        VARCHAR(255)          DEFAULT NULL,
  PRIMARY KEY (_id),
  UNIQUE KEY (email)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = UTF8;

INSERT INTO iam.MANAGEMENT_USER (_id, email, passwd, nm, description, authority, upd_dt, enabled, level, country)
VALUES
  ('1', 'support@iam.co.kr', 'MEVd1+d7s2DoZt8mgx+1kg==', '시스템 관리자', 'ROLE_ADMIN', NULL, CURRENT_TIMESTAMP, 1, 1, 'KR');

INSERT INTO iam.MANAGEMENT_USER (_id, email, passwd, nm, description, authority, upd_dt, enabled, level, country)
VALUES ('2', 'demo@iam.co.kr', 'MEVd1+d7s2DoZt8mgx+1kg==', '데모', 'ROLE_ADMIN', NULL, CURRENT_TIMESTAMP, 1, 1, 'KR');


CREATE TABLE IF NOT EXISTS iam.REGISTE (
  _id          VARCHAR(255) NOT NULL,
  userId       VARCHAR(255) NOT NULL,
  token        VARCHAR(255) NOT NULL,
  registration TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY (token),
  PRIMARY KEY (_id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS iam.COUNTRY;

CREATE TABLE iam.COUNTRY (
  code        VARCHAR(8) NOT NULL,
  countryName VARCHAR(150) DEFAULT NULL,
  PRIMARY KEY (code)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO COUNTRY
VALUES ('AD', 'Andorra'), ('AE', 'United Arab Emirates'), ('AF', 'Afghanistan'), ('AG', 'Antigua and Barbuda'),
  ('AI', 'Anguilla'), ('AL', 'Albania'), ('AM', 'Armenia'), ('AO', 'Angola'), ('AQ', 'Antarctica'), ('AR', 'Argentina'),
  ('AS', 'American Samoa'), ('AT', 'Austria'), ('AU', 'Australia'), ('AW', 'Aruba'), ('AX', 'Åland Islands'),
  ('AZ', 'Azerbaijan'), ('BA', 'Bosnia and Herzegovina'), ('BB', 'Barbados'), ('BD', 'Bangladesh'), ('BE', 'Belgium'),
  ('BF', 'Burkina Faso'), ('BG', 'Bulgaria'), ('BH', 'Bahrain'), ('BI', 'Burundi'), ('BJ', 'Benin'),
  ('BL', 'Saint Barthélemy'), ('BM', 'Bermuda'), ('BN', 'Brunei Darussalam'), ('BO', 'Bolivia, Plurinational State of'),
  ('BQ', 'Bonaire, Sint Eustatius and Saba'), ('BR', 'Brazil'), ('BS', 'Bahamas'), ('BT', 'Bhutan'),
  ('BV', 'Bouvet Island'), ('BW', 'Botswana'), ('BY', 'Belarus'), ('BZ', 'Belize'), ('CA', 'Canada'),
  ('CC', 'Cocos (Keeling) Islands'), ('CD', 'Congo, the Democratic Republic of the'),
  ('CF', 'Central African Republic'), ('CG', 'Congo'), ('CH', 'Switzerland'), ('CI', 'Côte d\'Ivoire'),
  ('CK', 'Cook Islands'), ('CL', 'Chile'), ('CM', 'Cameroon'), ('CN', 'China'), ('CO', 'Colombia'),
  ('CR', 'Costa Rica'), ('CU', 'Cuba'), ('CV', 'Cape Verde'), ('CW', 'Curaçao'), ('CX', 'Christmas Island'),
  ('CY', 'Cyprus'), ('CZ', 'Czech Republic'), ('DE', 'Germany'), ('DJ', 'Djibouti'), ('DK', 'Denmark'),
  ('DM', 'Dominica'), ('DO', 'Dominican Republic'), ('DZ', 'Algeria'), ('EC', 'Ecuador'), ('EE', 'Estonia'),
  ('EG', 'Egypt'), ('EH', 'Western Sahara'), ('ER', 'Eritrea'), ('ES', 'Spain'), ('ET', 'Ethiopia'), ('FI', 'Finland'),
  ('FJ', 'Fiji'), ('FK', 'Falkland Islands (Malvinas)'), ('FM', 'Micronesia, Federated States of'),
  ('FO', 'Faroe Islands'), ('FR', 'France'), ('GA', 'Gabon'), ('GB', 'United Kingdom'), ('GD', 'Grenada'),
  ('GE', 'Georgia'), ('GF', 'French Guiana'), ('GG', 'Guernsey'), ('GH', 'Ghana'), ('GI', 'Gibraltar'),
  ('GL', 'Greenland'), ('GM', 'Gambia'), ('GN', 'Guinea'), ('GP', 'Guadeloupe'), ('GQ', 'Equatorial Guinea'),
  ('GR', 'Greece'), ('GS', 'South Georgia and the South Sandwich Islands'), ('GT', 'Guatemala'), ('GU', 'Guam'),
  ('GW', 'Guinea-Bissau'), ('GY', 'Guyana'), ('HK', 'Hong Kong'), ('HM', 'Heard Island and McDonald Islands'),
  ('HN', 'Honduras'), ('HR', 'Croatia'), ('HT', 'Haiti'), ('HU', 'Hungary'), ('ID', 'Indonesia'), ('IE', 'Ireland'),
  ('IL', 'Israel'), ('IM', 'Isle of Man'), ('IN', 'India'), ('IO', 'British Indian Ocean Territory'), ('IQ', 'Iraq'),
  ('IR', 'Iran, Islamic Republic of'), ('IS', 'Iceland'), ('IT', 'Italy'), ('JE', 'Jersey'), ('JM', 'Jamaica'),
  ('JO', 'Jordan'), ('JP', 'Japan'), ('KE', 'Kenya'), ('KG', 'Kyrgyzstan'), ('KH', 'Cambodia'), ('KI', 'Kiribati'),
  ('KM', 'Comoros'), ('KN', 'Saint Kitts and Nevis'), ('KP', 'Korea, Democratic People\'s Republic of'),
  ('KR', 'Korea, Republic of'), ('KW', 'Kuwait'), ('KY', 'Cayman Islands'), ('KZ', 'Kazakhstan'),
  ('LA', 'Lao People\'s Democratic Republic'), ('LB', 'Lebanon'), ('LC', 'Saint Lucia'), ('LI', 'Liechtenstein'),
  ('LK', 'Sri Lanka'), ('LR', 'Liberia'), ('LS', 'Lesotho'), ('LT', 'Lithuania'), ('LU', 'Luxembourg'),
  ('LV', 'Latvia'), ('LY', 'Libya'), ('MA', 'Morocco'), ('MC', 'Monaco'), ('MD', 'Moldova, Republic of'),
  ('ME', 'Montenegro'), ('MF', 'Saint Martin (French part)'), ('MG', 'Madagascar'), ('MH', 'Marshall Islands'),
  ('MK', 'Macedonia, the former Yugoslav Republic of'), ('ML', 'Mali'), ('MM', 'Myanmar'), ('MN', 'Mongolia'),
  ('MO', 'Macao'), ('MP', 'Northern Mariana Islands'), ('MQ', 'Martinique'), ('MR', 'Mauritania'), ('MS', 'Montserrat'),
  ('MT', 'Malta'), ('MU', 'Mauritius'), ('MV', 'Maldives'), ('MW', 'Malawi'), ('MX', 'Mexico'), ('MY', 'Malaysia'),
  ('MZ', 'Mozambique'), ('NA', 'Namibia'), ('NC', 'New Caledonia'), ('NE', 'Niger'), ('NF', 'Norfolk Island'),
  ('NG', 'Nigeria'), ('NI', 'Nicaragua'), ('NL', 'Netherlands'), ('NO', 'Norway'), ('NP', 'Nepal'), ('NR', 'Nauru'),
  ('NU', 'Niue'), ('NZ', 'New Zealand'), ('OM', 'Oman'), ('PA', 'Panama'), ('PE', 'Peru'), ('PF', 'French Polynesia'),
  ('PG', 'Papua New Guinea'), ('PH', 'Philippines'), ('PK', 'Pakistan'), ('PL', 'Poland'),
  ('PM', 'Saint Pierre and Miquelon'), ('PN', 'Pitcairn'), ('PR', 'Puerto Rico'),
  ('PS', 'Palestinian Territory, Occupied'), ('PT', 'Portugal'), ('PW', 'Palau'), ('PY', 'Paraguay'), ('QA', 'Qatar'),
  ('RE', 'Réunion'), ('RO', 'Romania'), ('RS', 'Serbia'), ('RU', 'Russian Federation'), ('RW', 'Rwanda'),
  ('SA', 'Saudi Arabia'), ('SB', 'Solomon Islands'), ('SC', 'Seychelles'), ('SD', 'Sudan'), ('SE', 'Sweden'),
  ('SG', 'Singapore'), ('SH', 'Saint Helena, Ascension and Tristan da Cunha'), ('SI', 'Slovenia'),
  ('SJ', 'Svalbard and Jan Mayen'), ('SK', 'Slovakia'), ('SL', 'Sierra Leone'), ('SM', 'San Marino'), ('SN', 'Senegal'),
  ('SO', 'Somalia'), ('SR', 'Suriname'), ('SS', 'South Sudan'), ('ST', 'Sao Tome and Principe'), ('SV', 'El Salvador'),
  ('SX', 'Sint Maarten (Dutch part)'), ('SY', 'Syrian Arab Republic'), ('SZ', 'Swaziland'),
  ('TC', 'Turks and Caicos Islands'), ('TD', 'Chad'), ('TF', 'French Southern Territories'), ('TG', 'Togo'),
  ('TH', 'Thailand'), ('TJ', 'Tajikistan'), ('TK', 'Tokelau'), ('TL', 'Timor-Leste'), ('TM', 'Turkmenistan'),
  ('TN', 'Tunisia'), ('TO', 'Tonga'), ('TR', 'Turkey'), ('TT', 'Trinidad and Tobago'), ('TV', 'Tuvalu'),
  ('TW', 'Taiwan, Province of China'), ('TZ', 'Tanzania, United Republic of'), ('UA', 'Ukraine'), ('UG', 'Uganda'),
  ('UM', 'United States Minor Outlying Islands'), ('US', 'United States'), ('UY', 'Uruguay'), ('UZ', 'Uzbekistan'),
  ('VA', 'Holy See (Vatican City State)'), ('VC', 'Saint Vincent and the Grenadines'),
  ('VE', 'Venezuela, Bolivarian Republic of'), ('VG', 'Virgin Islands, British'), ('VI', 'Virgin Islands, U.S.'),
  ('VN', 'Viet Nam'), ('VU', 'Vanuatu'), ('WF', 'Wallis and Futuna'), ('WS', 'Samoa'), ('YE', 'Yemen'),
  ('YT', 'Mayotte'), ('ZA', 'South Africa'), ('ZM', 'Zambia'), ('ZW', 'Zimbabwe');

DROP TABLE IF EXISTS iam.MANAGEMENT;

CREATE TABLE iam.MANAGEMENT (
  _id                  VARCHAR(255) NOT NULL,
  userId               VARCHAR(255) NOT NULL,
  managementName       VARCHAR(255),
  managementKey        VARCHAR(255),
  managementSecret     VARCHAR(255),
  managementJwtSecret  VARCHAR(255),
  sessionTokenLifetime INTEGER   DEFAULT 3600,
  scopeCheckLifetime   INTEGER   DEFAULT 3600,
  description          LONGTEXT,
  regDate              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updDate              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (_id)
)
  ENGINE = INNODB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS iam.OAUTH_USER;

CREATE TABLE iam.OAUTH_USER (
  _id                   VARCHAR(255) NOT NULL,
  managementId          VARCHAR(255) NOT NULL,
  userName              VARCHAR(255) NOT NULL,
  userPassword          VARCHAR(255) NOT NULL,
  name                  VARCHAR(255),
  level                 SMALLINT     NOT NULL DEFAULT 5,
  additionalInformation LONGTEXT,
  regDate               TIMESTAMP             DEFAULT CURRENT_TIMESTAMP,
  updDate               TIMESTAMP             DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (_id)
)
  ENGINE = INNODB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS iam.OAUTH_CLIENT;

CREATE TABLE iam.OAUTH_CLIENT (
  _id                  VARCHAR(255) NOT NULL,
  managementId         VARCHAR(255) NOT NULL,
  name                 VARCHAR(255),
  description          LONGTEXT,
  clientKey            VARCHAR(255),
  clientSecret         VARCHAR(255),
  clientJwtSecret      VARCHAR(255),
  clientTrust          VARCHAR(255) COMMENT 'trust/3th_party',
  clientType           VARCHAR(255) COMMENT 'public/confidential',
  activeClient         CHAR(1),
  authorizedGrantTypes VARCHAR(255),
  webServerRedirectUri VARCHAR(255),
  refreshTokenValidity CHAR(1),
  codeLifetime         INTEGER   DEFAULT 3600,
  refreshTokenLifetime INTEGER   DEFAULT 3600,
  accessTokenLifetime  INTEGER   DEFAULT 3600,
  jwtTokenLifetime     INTEGER   DEFAULT 3600,
  regDate              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updDate              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (_id)
)
  ENGINE = INNODB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS iam.OAUTH_SCOPES;

CREATE TABLE iam.OAUTH_SCOPES (
  _id                   VARCHAR(255) NOT NULL,
  managementId          VARCHAR(255) NOT NULL,
  name                  VARCHAR(255),
  description           LONGTEXT,
  additionalInformation LONGTEXT,
  regDate               TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updDate               TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (_id)
)
  ENGINE = INNODB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS iam.OAUTH_CLIENT_SCOPES;

CREATE TABLE iam.OAUTH_CLIENT_SCOPES (
  _id      VARCHAR(255) NOT NULL,
  clientId VARCHAR(255) NOT NULL,
  scopeId  VARCHAR(255) NOT NULL,
  regDate  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updDate  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (_id)
)
  ENGINE = INNODB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS iam.OAUTH_ACCESS_TOKEN;

CREATE TABLE iam.OAUTH_ACCESS_TOKEN (
  _id                   VARCHAR(255) NOT NULL,
  type                  VARCHAR(255) COMMENT 'client/user',
  scopes                LONGTEXT,
  token                 LONGTEXT     NOT NULL,
  oauthUserId           VARCHAR(255),
  managementId          VARCHAR(255) NOT NULL,
  clientId              VARCHAR(255) NOT NULL,
  refreshToken          LONGTEXT,
  additionalInformation LONGTEXT,
  regDate               TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updDate               TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (_id)
)
  ENGINE = INNODB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS iam.OAUTH_CODE;

CREATE TABLE iam.OAUTH_CODE (
  _id          VARCHAR(255) NOT NULL,
  managementId VARCHAR(255) NOT NULL,
  clientId     VARCHAR(255) NOT NULL,
  oauthUserId  VARCHAR(255) NOT NULL,
  code         LONGTEXT     NOT NULL,
  scopes       LONGTEXT,
  regDate      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updDate      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (_id)
)
  ENGINE = INNODB
  DEFAULT CHARSET = utf8;



