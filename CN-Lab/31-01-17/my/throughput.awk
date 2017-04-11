BEGIN {
         recv = 0
 }
 
 {
         # Trace line format: normal
         if ($2 != "-t") {
                 event = $1
                 time = $2
                 if (event == "+" || event == "-") node_id = $3
                 if (event == "r" || event == "d") node_id = $4
                 flow_id = $8
                 pkt_id = $12
                 pkt_size = $6
         }
         # Trace line format: new
         if ($2 == "-t") {
                 event = $1
                 time = $3
                 node_id = $5
                 flow_id = $39
                 pkt_id = $41
                 pkt_size = $37
         }
 
         # Calculate total received packets' size
         if (flow_id == flow && event == "r" && node_id == dst) {
                 if (flow_t != "sctp") {
                         recv += pkt_size - hdr_size
                         print "recv[%g] = %g --> tot:%g\n", node_id,pkt_size-hdr_size, recv;
                 } else {
                         # Rip off SCTP header, whose size depends
                         # on the number of chunks in each packet
                         if (pkt_size == 40) pkt_size = 0
                         if (pkt_size == 448) pkt_size = 400
                         if (pkt_size == 864) pkt_size = 800
                         if (pkt_size == 1280) pkt_size = 1200
                         recv += pkt_size
                         print "recv[%g] = %g --> tot: %g\n", node_id, pkt_size,recv;
                 }
         }
 }
 
 END {
         print "%10g %10s %10g\n", flow, flow_t, (recv/simtime)*(8/1000);
 }
