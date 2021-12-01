class Document < ApplicationRecord
  belongs_to :supplier

  enum RAG: { :red, :amber, :green }
  enum importance: { :very_high, :high, :medium, :low }
end
