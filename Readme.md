## Inductor Knowledge Based System

The Inductor KBS takes as input an inductor specification and generates an inductor design. 

By default it is set to look for inductance and flux density to be within 5% of their target (2mH and 
1.4T respectively). The Power Loss must be less than 3.4. The system does not check for Window, Weight, Volume, and Cost problems.

The KBS is an implementation of work by Dr. Sadeghian (http://www.scs.ryerson.ca/~asadeghi/) on the CLIPS inference engine available at http://clipsrules.sourceforge.net/

__To Run open CLIPS and enter the following:__

(clear)

(reset)

(load "%path%/KBS-Main.clp")

(load-files "%path%")

(core-constants-create-table)

(core-data-table-create-table)

(wire-data-table-create-table)

(requested-design-get-input 0) ; remove the zero to input your own design request

(run)


License
-------

__Simplified:__ http://www.tldrlegal.com/license/apache-license-2.0-(apache-2.0)

Copyright 2014 Graham Holker

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.