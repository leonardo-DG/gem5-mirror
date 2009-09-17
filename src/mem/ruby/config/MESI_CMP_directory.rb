require "cfg.rb"
require "util.rb"


class MESI_CMP_directory_L2CacheController < CacheController
  attr :cache

  def initialize(obj_name, mach_type, cache)
    super(obj_name, mach_type, [cache])
    @cache = cache
  end
  def argv()
    vec = super()
    vec += " cache " + cache.obj_name
    vec += " l2_request_latency "+l2_request_latency.to_s 
    vec += " l2_response_latency "+l2_response_latency.to_s
    vec += " to_l1_latency "+to_L1_latency.to_s
    return vec
  end

end

class MESI_CMP_directory_L1CacheController < L1CacheController
  attr :icache, :dcache
  attr :num_l2_controllers

  def initialize(obj_name, mach_type, icache, dcache, sequencer, num_l2_controllers)
    super(obj_name, mach_type, [icache, dcache], sequencer)
    @icache = icache
    @dcache = dcache
    @num_l2_controllers = num_l2_controllers
  end

  def argv()
    num_select_bits = log_int(num_l2_controllers)
    num_block_bits = log_int(RubySystem.block_size_bytes)
    l2_select_low_bit = num_block_bits

    vec = super()
    vec += " icache " + @icache.obj_name
    vec += " dcache " + @dcache.obj_name   
    vec += " l1_request_latency "+l1_request_latency.to_s 
    vec += " l1_response_latency "+l1_response_latency.to_s
    vec += " to_l2_latency "+to_L2_latency.to_s
    vec += " l2_select_low_bit " + l2_select_low_bit.to_s
    vec += " l2_select_num_bits " + num_select_bits.to_s
    return vec
  end

end

class MESI_CMP_directory_DMAController < DMAController
  def initialize(obj_name, mach_type, dma_sequencer)
    super(obj_name, mach_type, dma_sequencer)
  end
  def argv()
    vec = super
    vec += " request_latency "+request_latency.to_s
    return vec
  end
end


class MESI_CMP_directory_DirectoryController < DirectoryController
  def initialize(obj_name, mach_type, directory, memory_control) 
    super(obj_name, mach_type, directory, memory_control)
  end
  def argv()
    vec = super()
    vec += " to_mem_ctrl_latency "+to_mem_ctrl_latency.to_s 
    vec += " directory_latency "+directory_latency.to_s
  end

end
require "defaults.rb"