class BadScoreError < StandardError
  def initialize(msg = 'Invalid hand score')
    super
  end
end
