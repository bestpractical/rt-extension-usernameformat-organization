use inc::Module::Install;

RTx 'RT-Extension-UsernameFormat-Organization';
readme_from 'lib/RT/Extension/UsernameFormat/Organization.pm';
license  'gplv2';

requires_rt '4.2.0';

sign;
WriteAll;
