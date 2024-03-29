package SXIP::Digest;

=head1 NAME

SXIP::Digest - SXIP protocol digest algorithm

=head1 SYNOPSIS

    use SXIP::Digest 'sxip_digest';

    my $digest = sxip_digest(\%message);

=cut

use strict;
use warnings;
use base 'Exporter';
use Digest::SHA1 'sha1_hex';
our @EXPORT_OK = qw/sxip_digest/;
our $VERSION = '1.0.0';

=head1 METHODS

=over

=item B<my $digest = sxip_digest(\%message)>

Returns a SXIP digest of a SXIP message.

Parameters:

=over

=item $message 

The SXIP response message.  Normally this will just be a hashref of all the
POST parameters received by the Membersite.  For a repeating POST parameter,
the hash value should be an array ref.

=back

=cut

sub sxip_digest {
    my $message = shift;
    my @pairs;
    while (my ($k, $v) = each %$message) {
        next if $k eq 'dix:/signature';
        my @v = ref $v eq 'ARRAY' ? @$v : $v;
        push @pairs, map(_encode($k) . "=" . _encode($_), @v);
    }
    return sha1_hex(join('&', sort @pairs));
}

sub _encode {
    local $_ = shift;
    s/([&%=])/sprintf("\U%%%02x\E",ord($1))/eg;
    return $_;
}

1;

=head1 AUTHOR

Sxip Identity, C<< <dev at sxip.org> >>

=head1 COPYRIGHT & LICENSE

The Sxip Identity Software License, Version 1

Copyright (c) 2004-2006 Sxip Identity Corporation. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in
   the documentation and/or other materials provided with the
   distribution.

3. The end-user documentation included with the redistribution,
   if any, must include the following acknowledgment:
      "This product includes software developed by
       Sxip Identity Corporation (http://sxip.org)."
   Alternately, this acknowledgment may appear in the software itself,
   if and wherever such third-party acknowledgments normally appear.

4. The names "Sxip" and "Sxip Identity" must not be used to endorse
   or promote products derived from this software without prior
   written permission. For written permission, please contact
   bizdev@sxip.org.

5. Products derived from this software may not be called "Sxip",
   nor may "Sxip" appear in their name, without prior written
   permission of Sxip Identity Corporation.

THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESSED OR IMPLIED
WARRANTIES OR CONDITIONS, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OR CONDITIONS OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL SXIP NETWORKS OR ITS
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

