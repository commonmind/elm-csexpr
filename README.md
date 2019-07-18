An Elm package for working with [Canonical S-expressions][1]

Note: if you're viewing this README on GitHub, be aware that this is a
mirror of our [GitLab repo][2]; please open issues and pull requests
there.

# Introduction

Canonical S-expressions allow you to encode and decode structured data,
like JSON, but unlike JSON, there is only one possible ("canonical")
encoding for a given value.

This means that two encodings are equal if and only if the values are
equal. This makes it possible to use them as dictionary keys, both with
Elm's `Dict` type and other applications where values are compared by
looking at the raw bytes (including many cryptographic applications,
which is what they were designed for).

Canonical S-expressions are simpler than JSON; they only have two types:

* lists
* "atoms"

Atoms are just flat bytes, while lists are lists of other s-expressions.
Note that while according to the standard, canonical s-expressions can
encode binary data, this package does not support that -- atoms must be
strings. The reason for this is that elm's `Bytes` type cannot be used
as a `Dict` key, so encoding to `Bytes` would defeat the point of the
package.

See the Wikipedia article linked above for more general information
about canonical s-expressions.

# License

Copyright (C) 2019 CommonMind LLC

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

[1]: https://en.wikipedia.org/wiki/Canonical_S-expressions
[2]: https://gitlab.com/commonmind/elm-csexpr
