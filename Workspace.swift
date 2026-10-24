workflows:
  ios-workflow:
    name: Flix Vision iOS Workflow
    max_build_duration: 120
    environment:
      xcode: latest
      cocoapods: default
    scripts:
      - name: Install Tuist and generate project
        script: |
          curl -Ls https://git.io/tuist | bash
          tuist generate --no-open
      - name: Build ipa with xcodebuild
        script: |
          xcodebuild -workspace FlixVision.xcworkspace -scheme FlixVision -sdk iphoneos -configuration Release archive -archivePath build/FlixVision.xcarchive CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED=NO
          mkdir -p build/ios/ipa
          # ئەگەر ئەشیپەرێتەوە، فایلی ئایفۆن لە ناو ئەڕشیفەکە دەهێنە دەرەوە
          cd build/FlixVision.xcarchive/Products/Applications/
          zip -r ../../../build/ios/ipa/FlixVision.zip .
          cd -
    artifacts:
      - build/ios/ipa/*.ipa
      - build/ios/ipa/*.zip
