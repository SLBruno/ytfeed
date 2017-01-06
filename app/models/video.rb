class Video < ApplicationRecord
  validates_uniqueness_of :url

  def self.YTCHID
    %w(UCDUdvPnNWjQCif_GnrhUE6Q UCxfiU1Yr2qwbhrvibG03aBw UCYScNUfCLI_LBmUzfHIZ0lg UCIhmXuqtOQVJCPbh_tXns1g)
  end

end
