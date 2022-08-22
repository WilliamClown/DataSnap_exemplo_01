{$IFDEF VER350}
  {$DEFINE DELPHI_ALEXANDRIA}
  {$DEFINE DELPHI_SYDNEY_UP}
  {$DEFINE DELPHI_RIO_UP}
  {$DEFINE DELPHI_TOKYO_UP}
  {$DEFINE DELPHI_BERLIN_UP}
  {$DEFINE DELPHI_SEATLE_UP}
  {$DEFINE DELPHI_XE8_UP}
  {$DEFINE DELPHI_XE7_UP}
  {$DEFINE DELPHI_XE6_UP}
  {$DEFINE DELPHI_XE5_UP}
  {$DEFINE DELPHI_XE4_UP}
  {$DEFINE DELPHI_XE3_UP}
  {$DEFINE DELPHI_XE2_UP}
  {$DEFINE DELPHI_XE_UP}
  {$DEFINE DELPHI_2010_UP}
{$ELSE}
  {$IFDEF VER340}
    {$DEFINE DELPHI_ALEXANDRIA_BELLOW}
    {$DEFINE DELPHI_SYDNEY}
    {$DEFINE DELPHI_RIO_UP}
    {$DEFINE DELPHI_TOKYO_UP}
    {$DEFINE DELPHI_BERLIN_UP}
    {$DEFINE DELPHI_SEATLE_UP}
    {$DEFINE DELPHI_XE8_UP}
    {$DEFINE DELPHI_XE7_UP}
    {$DEFINE DELPHI_XE6_UP}
    {$DEFINE DELPHI_XE5_UP}
    {$DEFINE DELPHI_XE4_UP}
    {$DEFINE DELPHI_XE3_UP}
    {$DEFINE DELPHI_XE2_UP}
    {$DEFINE DELPHI_XE_UP}
    {$DEFINE DELPHI_2010_UP}
  {$ELSE}
    {$IFDEF VER330}
      {$DEFINE DELPHI_ALEXANDRIA_BELLOW}
      {$DEFINE DELPHI_SYDNEY_BELLOW}
      {$DEFINE DELPHI_RIO}
      {$DEFINE DELPHI_TOKYO_UP}
      {$DEFINE DELPHI_BERLIN_UP}
      {$DEFINE DELPHI_SEATLE_UP}
      {$DEFINE DELPHI_XE8_UP}
      {$DEFINE DELPHI_XE7_UP}
      {$DEFINE DELPHI_XE6_UP}
      {$DEFINE DELPHI_XE5_UP}
      {$DEFINE DELPHI_XE4_UP}
      {$DEFINE DELPHI_XE3_UP}
      {$DEFINE DELPHI_XE2_UP}
      {$DEFINE DELPHI_XE_UP}
      {$DEFINE DELPHI_2010_UP}
    {$ELSE}
      {$IFDEF VER320}
        {$DEFINE DELPHI_ALEXANDRIA_BELLOW}
        {$DEFINE DELPHI_SYDNEY_BELLOW}
        {$DEFINE DELPHI_RIO_BELLOW}
        {$DEFINE DELPHI_TOKYO}
        {$DEFINE DELPHI_BERLIN_UP}
        {$DEFINE DELPHI_SEATLE_UP}
        {$DEFINE DELPHI_XE8_UP}
        {$DEFINE DELPHI_XE7_UP}
        {$DEFINE DELPHI_XE6_UP}
        {$DEFINE DELPHI_XE5_UP}
        {$DEFINE DELPHI_XE4_UP}
        {$DEFINE DELPHI_XE3_UP}
        {$DEFINE DELPHI_XE2_UP}
        {$DEFINE DELPHI_XE_UP}
        {$DEFINE DELPHI_2010_UP}
        {$ELSE}
        {$IFDEF VER310}
          {$DEFINE DELPHI_ALEXANDRIA_BELLOW}
          {$DEFINE DELPHI_SYDNEY_BELLOW}
          {$DEFINE DELPHI_RIO_BELLOW}
          {$DEFINE DELPHI_TOKYO_BELLOW}
          {$DEFINE DELPHI_BERLIN}
          {$DEFINE DELPHI_SEATLE_UP}
          {$DEFINE DELPHI_XE8_UP}
          {$DEFINE DELPHI_XE7_UP}
          {$DEFINE DELPHI_XE6_UP}
          {$DEFINE DELPHI_XE5_UP}
          {$DEFINE DELPHI_XE4_UP}
          {$DEFINE DELPHI_XE3_UP}
          {$DEFINE DELPHI_XE2_UP}
          {$DEFINE DELPHI_XE_UP}
          {$DEFINE DELPHI_2010_UP}
        {$ELSE}
          {$IFDEF VER300}
            {$DEFINE DELPHI_ALEXANDRIA_BELLOW}
            {$DEFINE DELPHI_SYDNEY_BELLOW}
            {$DEFINE DELPHI_RIO_BELLOW}
            {$DEFINE DELPHI_TOKYO_BELLOW}
            {$DEFINE DELPHI_BERLIN_BELLOW}
            {$DEFINE DELPHI_SEATLE}
            {$DEFINE DELPHI_XE8_UP}
            {$DEFINE DELPHI_XE7_UP}
            {$DEFINE DELPHI_XE6_UP}
            {$DEFINE DELPHI_XE5_UP}
            {$DEFINE DELPHI_XE4_UP}
            {$DEFINE DELPHI_XE3_UP}
            {$DEFINE DELPHI_XE2_UP}
            {$DEFINE DELPHI_XE_UP}
            {$DEFINE DELPHI_2010_UP}
          {$ELSE}
            {$IFDEF VER290}
              {$DEFINE DELPHI_ALEXANDRIA_BELLOW}
              {$DEFINE DELPHI_SYDNEY_BELLOW}
              {$DEFINE DELPHI_RIO_BELLOW}
              {$DEFINE DELPHI_TOKYO_BELLOW}
              {$DEFINE DELPHI_BERLIN_BELLOW}
              {$DEFINE DELPHI_SEATLE_BELLOW}
              {$DEFINE DELPHI_XE8}
              {$DEFINE DELPHI_XE7_UP}
              {$DEFINE DELPHI_XE6_UP}
              {$DEFINE DELPHI_XE5_UP}
              {$DEFINE DELPHI_XE4_UP}
              {$DEFINE DELPHI_XE3_UP}
              {$DEFINE DELPHI_XE2_UP}
              {$DEFINE DELPHI_XE_UP}
              {$DEFINE DELPHI_2010_UP}
            {$ELSE}
              {$IFDEF VER280}
                {$DEFINE DELPHI_ALEXANDRIA_BELLOW}
                {$DEFINE DELPHI_SYDNEY_BELLOW}
                {$DEFINE DELPHI_RIO_BELLOW}
                {$DEFINE DELPHI_TOKYO_BELLOW}
                {$DEFINE DELPHI_BERLIN_BELLOW}
                {$DEFINE DELPHI_SEATLE_BELLOW}
                {$DEFINE DELPHI_XE8_BELLOW}
                {$DEFINE DELPHI_XE7}
                {$DEFINE DELPHI_XE6_UP}
                {$DEFINE DELPHI_XE5_UP}
                {$DEFINE DELPHI_XE4_UP}
                {$DEFINE DELPHI_XE3_UP}
                {$DEFINE DELPHI_XE2_UP}
                {$DEFINE DELPHI_XE_UP}
                {$DEFINE DELPHI_2010_UP}
              {$ELSE}
                {$IFDEF VER270}
                  {$DEFINE DELPHI_ALEXANDRIA_BELLOW}
                  {$DEFINE DELPHI_SYDNEY_BELLOW}
                  {$DEFINE DELPHI_RIO_BELLOW}
                  {$DEFINE DELPHI_TOKYO_BELLOW}
                  {$DEFINE DELPHI_BERLIN_BELLOW}
                  {$DEFINE DELPHI_SEATLE_BELLOW}
                  {$DEFINE DELPHI_XE8_BELLOW}
                  {$DEFINE DELPHI_XE7_BELLOW}
                  {$DEFINE DELPHI_XE6}
                  {$DEFINE DELPHI_XE5_UP}
                  {$DEFINE DELPHI_XE4_UP}
                  {$DEFINE DELPHI_XE3_UP}
                  {$DEFINE DELPHI_XE2_UP}
                  {$DEFINE DELPHI_XE_UP}
                  {$DEFINE DELPHI_2010_UP}
                {$ELSE}
                  {$IFDEF VER260}
                    {$DEFINE DELPHI_ALEXANDRIA_BELLOW}
                    {$DEFINE DELPHI_SYDNEY_BELLOW}
                    {$DEFINE DELPHI_RIO_BELLOW}
                    {$DEFINE DELPHI_TOKYO_BELLOW}
                    {$DEFINE DELPHI_BERLIN_BELLOW}
                    {$DEFINE DELPHI_SEATLE_BELLOW}
                    {$DEFINE DELPHI_XE8_BELLOW}
                    {$DEFINE DELPHI_XE7_BELLOW}
                    {$DEFINE DELPHI_XE6_BELLOW}
                    {$DEFINE DELPHI_XE5}
                    {$DEFINE DELPHI_XE4_UP}
                    {$DEFINE DELPHI_XE3_UP}
                    {$DEFINE DELPHI_XE2_UP}
                    {$DEFINE DELPHI_XE_UP}
                    {$DEFINE DELPHI_2010_UP}
                  {$ELSE}
                    {$IFDEF VER250}
                      {$DEFINE DELPHI_ALEXANDRIA_BELLOW}
                      {$DEFINE DELPHI_SYDNEY_BELLOW}
                      {$DEFINE DELPHI_RIO_BELLOW}
                      {$DEFINE DELPHI_TOKYO_BELLOW}
                      {$DEFINE DELPHI_BERLIN_BELLOW}
                      {$DEFINE DELPHI_SEATLE_BELLOW}
                      {$DEFINE DELPHI_XE8_BELLOW}
                      {$DEFINE DELPHI_XE7_BELLOW}
                      {$DEFINE DELPHI_XE6_BELLOW}
                      {$DEFINE DELPHI_XE5_BELLOW}
                      {$DEFINE DELPHI_XE4}
                      {$DEFINE DELPHI_XE3_UP}
                      {$DEFINE DELPHI_XE2_UP}
                      {$DEFINE DELPHI_XE_UP}
                      {$DEFINE DELPHI_2010_UP}
                    {$ELSE}
                      {$IFDEF VER240}
                        {$DEFINE DELPHI_ALEXANDRIA_BELLOW}
                        {$DEFINE DELPHI_SYDNEY_BELLOW}
                        {$DEFINE DELPHI_RIO_BELLOW}
                        {$DEFINE DELPHI_TOKYO_BELLOW}
                        {$DEFINE DELPHI_BERLIN_BELLOW}
                        {$DEFINE DELPHI_SEATLE_BELLOW}
                        {$DEFINE DELPHI_XE8_BELLOW}
                        {$DEFINE DELPHI_XE7_BELLOW}
                        {$DEFINE DELPHI_XE6_BELLOW}
                        {$DEFINE DELPHI_XE5_BELLOW}
                        {$DEFINE DELPHI_XE4_BELLOW}
                        {$DEFINE DELPHI_XE3}
                        {$DEFINE DELPHI_XE2_UP}
                        {$DEFINE DELPHI_XE_UP}
                        {$DEFINE DELPHI_2010_UP}
                      {$ELSE}
                        {$IFDEF VER230}
                          {$DEFINE DELPHI_ALEXANDRIA_BELLOW}
                          {$DEFINE DELPHI_SYDNEY_BELLOW}
                          {$DEFINE DELPHI_RIO_BELLOW}
                          {$DEFINE DELPHI_TOKYO_BELLOW}
                          {$DEFINE DELPHI_BERLIN_BELLOW}
                          {$DEFINE DELPHI_SEATLE_BELLOW}
                          {$DEFINE DELPHI_XE8_BELLOW}
                          {$DEFINE DELPHI_XE7_BELLOW}
                          {$DEFINE DELPHI_XE6_BELLOW}
                          {$DEFINE DELPHI_XE5_BELLOW}
                          {$DEFINE DELPHI_XE4_BELLOW}
                          {$DEFINE DELPHI_XE3_BELLOW}
                          {$DEFINE DELPHI_XE2}
                          {$DEFINE DELPHI_XE_UP}
                          {$DEFINE DELPHI_2010_UP}
                        {$ELSE}
                          {$IFDEF VER220}
                            {$DEFINE DELPHI_ALEXANDRIA_BELLOW}
                            {$DEFINE DELPHI_SYDNEY_BELLOW}
                            {$DEFINE DELPHI_RIO_BELLOW}
                            {$DEFINE DELPHI_TOKYO_BELLOW}
                            {$DEFINE DELPHI_BERLIN_BELLOW}
                            {$DEFINE DELPHI_SEATLE_BELLOW}
                            {$DEFINE DELPHI_XE8_BELLOW}
                            {$DEFINE DELPHI_XE7_BELLOW}
                            {$DEFINE DELPHI_XE6_BELLOW}
                            {$DEFINE DELPHI_XE5_BELLOW}
                            {$DEFINE DELPHI_XE4_BELLOW}
                            {$DEFINE DELPHI_XE3_BELLOW}
                            {$DEFINE DELPHI_XE2_BELLOW}
                            {$DEFINE DELPHI_XE}
                            {$DEFINE DELPHI_2010_UP}
                          {$ELSE}
                            {$IFDEF VER210}
                              {$DEFINE DELPHI_ALEXANDRIA_BELLOW}
                              {$DEFINE DELPHI_SYDNEY_BELLOW}
                              {$DEFINE DELPHI_RIO_BELLOW}
                              {$DEFINE DELPHI_TOKYO_BELLOW}
                              {$DEFINE DELPHI_BERLIN_BELLOW}
                              {$DEFINE DELPHI_SEATLE_BELLOW}
                              {$DEFINE DELPHI_XE8_BELLOW}
                              {$DEFINE DELPHI_XE7_BELLOW}
                              {$DEFINE DELPHI_XE6_BELLOW}
                              {$DEFINE DELPHI_XE5_BELLOW}
                              {$DEFINE DELPHI_XE4_BELLOW}
                              {$DEFINE DELPHI_XE3_BELLOW}
                              {$DEFINE DELPHI_XE2_BELLOW}
                              {$DEFINE DELPHI_XE_BELLOW}
                              {$DEFINE DELPHI_2010}
                            {$ELSE}
                              {$if defined(VER200) or defined(VER190)  or defined(VER185) or
                                   defined(VER180) or defined(VER170)  or defined(VER160) or
                                   defined(VER150) or defined(VER140)  or defined(VER130) or
                                   defined(VER120) or defined(VER110)  or defined(VER100) or
                                   defined(VER90) or defined(VER80)}
                                {$DEFINE DELPHI_ALEXANDRIA_BELLOW}
                                {$DEFINE DELPHI_SYDNEY_BELLOW}
                                {$DEFINE DELPHI_RIO_BELLOW}
                                {$DEFINE DELPHI_TOKYO_BELLOW}
                                {$DEFINE DELPHI_BERLIN_BELLOW}
                                {$DEFINE DELPHI_SEATLE_BELLOW}
                                {$DEFINE DELPHI_XE8_BELLOW}
                                {$DEFINE DELPHI_XE7_BELLOW}
                                {$DEFINE DELPHI_XE6_BELLOW}
                                {$DEFINE DELPHI_XE5_BELLOW}
                                {$DEFINE DELPHI_XE4_BELLOW}
                                {$DEFINE DELPHI_XE3_BELLOW}
                                {$DEFINE DELPHI_XE2_BELLOW}
                                {$DEFINE DELPHI_XE_BELLOW}
                                {$DEFINE DELPHI_2010_BELLOW}
                              {$ifend}
                            {$ENDIF}
                          {$ENDIF}
                        {$ENDIF}
                      {$ENDIF}
                    {$ENDIF}
                  {$ENDIF}
                {$ENDIF}
              {$ENDIF}
            {$ENDIF}
          {$ENDIF}
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
