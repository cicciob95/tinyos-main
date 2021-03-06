/*
 * Copyright (c) 2011 University of Utah. 
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:  
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the copyright holder nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/**
 * @author Thomas Schmid
 */

#include "sam3sadchardware.h"
generic configuration AdcReadStreamClientC()
{ 
  provides {
    interface ReadStream<uint16_t>;
  }
  uses interface AdcConfigure<const sam3s_adc_channel_config_t*>;
} 

implementation {

#ifndef SAM3S_ADC_PDC
  components AdcStreamP;
#else
  components AdcStreamPDCP as AdcStreamP;
#endif
  components new Sam3sAdcClientC();
  components WireAdcStreamP;

  enum {
    CLIENT = unique(ADCC_READ_STREAM_SERVICE),
  };

  ReadStream = WireAdcStreamP.ReadStream[CLIENT];
  AdcConfigure = WireAdcStreamP.AdcConfigure[CLIENT];

  WireAdcStreamP.Resource[CLIENT] -> Sam3sAdcClientC.Resource;
  WireAdcStreamP.Sam3sGetAdc[CLIENT] -> Sam3sAdcClientC.Sam3sGetAdc;
}
