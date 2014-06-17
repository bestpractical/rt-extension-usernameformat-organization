use strict;
use warnings;
package RT::Extension::UsernameFormat::Organization;

our $VERSION = '0.01';

=head1 NAME

RT-Extension-UsernameFormat-Organization - Adds a username format option for "Name [Org, City, Country]"

=head1 DESCRIPTION

Adds "Name [Organization, City, Country]" to the "Username format" preference.

Only non-empty values are shown, so if your users only have an organization and
city you'd see something like "John Smith [Best Practical, Boston]" without any
country.  The same goes for Organization and City.

=cut

my $meta = RT->Config->Meta('UsernameFormat');
push @{$meta->{WidgetArguments}{Values}}, 'organization';
$meta->{WidgetArguments}{ValuesLabel}{organization} = 'Name [Organization, City, Country]';

package RT::User;
no warnings 'redefine';

sub _FormatUserOrganization {
    my $self = shift;
    my %args = @_;

    my $value = $self->_FormatUserRole(@_);

    if ($args{User}) {
        my $org = join ", ", grep { defined && length }
            map { $args{User}->$_ }
                qw(Organization City Country);
        $value .= " [$org]" if $org;
    }

    return $value;
}

package RT::Extension::UsernameFormat::Organization;

=head1 INSTALLATION 

=over

=item perl Makefile.PL

=item make

=item make install

May need root permissions

=item Edit your /opt/rt4/etc/RT_SiteConfig.pm

Add this line:

    Set(@Plugins, qw(RT::Extension::UsernameFormat::Organization));

or add C<RT::Extension::UsernameFormat::Organization> to your existing C<@Plugins> line.

=item Clear your mason cache

    rm -rf /opt/rt4/var/mason_data/obj

=item Restart your webserver

=item Navigate to Logged in as... then Settings and select the new Username Format

=back

=head1 AUTHOR

Thomas Sibley <trs@bestpractical.com>

=head1 BUGS

All bugs should be reported via
L<http://rt.cpan.org/Public/Dist/Display.html?Name=RT-Extension-UsernameFormat-Organization>
or L<bug-RT-Extension-UsernameFormat-Organization@rt.cpan.org>.


=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2012 by Best Practical Solutions

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut

1;
