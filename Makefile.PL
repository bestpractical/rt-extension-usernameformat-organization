use inc::Module::Install;


RTx 'RT-Extension-UsernameFormat-Organization';
all_from 'lib/RT/Extension/UsernameFormat/Organization.pm';
readme_from 'lib/RT/Extension/UsernameFormat/Organization.pm';
license  'gplv2';

sign;
WriteAll;
