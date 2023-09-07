 Raspberry Pi Rack
===================

I have a cluster of RPis that i use for various purposes and I'd like to keep
them cool in a compact package. There are 3 ways to extract heat: convection,
conduction, and radiation. Convection is most effective way of cooling a PCB
(i.e. adding a fan). However, adding a fan per Raspberry pi does not seem like
a cost effecitve design.  You can buy small cheap fans but they are noisy and
likely to fail.  You can buy nice fans, but that will cost a lot.  If i could
find a way to use 1 fan to cool the entire cluster, that would allow me to get
the best of both worlds

Overview
========

In this project, i will create a 3D printed raspberry pi rack. The pis will be
arranged in a straight line that can be mounted on the wall or peg board. The
case holding the pis will form a long tube.  A high quality, high air flow
centrafugal fan will be located on 1 end of the tube, generating a significant
amount of air flow over every rasbperry pi.  Each pi will be mounted on a sled
that will alow you to remove, service, and replace pis without disruting the
others.


Power Delivery
==============

The most common ports for server applications ( USB, Ethernet) are located on 1
edge of the PCB.  The only port i care about *not* located onthis edge is the
power plug.  Rather than buying a bunch of 90 degree USB-C cables tnat punching
holes in my "tube", I will directly tap into the 5V pin on the header.  The
sled that mounts the pi will have a small 5V regulator.  This sled will get
power from a 12V bus-bar which will travel through the tube.  tabs on the sled
will lock into slots in the tube.  Both sides will be covered in copper tape.
The 5V regualtor board will be soldered to the copper tape on the sled.  the
copper tape on the slots will connect to the bus bar via Nickle-plated sheet
metal screws. 

