require "spec_helper"
require_relative "../lib/bad_example"

# These tests are terrible!
# They're just to demonstrate how to include LocalStack in GitHub Actions
describe BadExample do
  before(:all) { `awslocal s3 mb s3://#{ENV["BUCKET_NAME"]}` }
  after(:all) { `awslocal s3 rb s3://#{ENV["BUCKET_NAME"]} --force` }

  let(:bad_example) { described_class.new(bucket: ENV["BUCKET_NAME"]) }
  let(:object_key) { "example.txt" }
  let(:object_path) { "s3://#{ENV["BUCKET_NAME"]}/#{object_key}" }

  describe "#upload" do
    let(:file_path) { "spec/fixtures/example.txt" }

    it "uploads an object to S3" do
      bad_example.upload(file_path, object_key)

      expect(`awslocal s3 ls #{object_path}`)
        .to match(/25 #{object_key}/)
    end
  end

  describe "#download" do
    before do
      `awslocal s3 cp spec/fixtures/example.txt #{object_path}`
    end

    it "downloads the requested file from S3" do
      response = bad_example.download(object_key)

      expect(response.body.read).to eq("Hello!\n")
    end
  end
end
