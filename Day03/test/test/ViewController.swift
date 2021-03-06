//
//  ViewController.swift
//  test
//
//  Created by Admin on 20.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{

    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 5.0, bottom: 0.0, right: 5.0)
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as? CollectionViewCell
        let view = segue.destination as? ImageController
      
        view?.download(url: URL(string:(cell?.link)!)!)
    
    }
    
    var images=[
       "https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-ADcEdwasFEQ%2fVkHJWCmn73I%2fAAAAAAAAUAs%2fb1iOzJvNuGQ%2fs16000%2f0000-001.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-IKy1d4DXQYU%2fVkHEy4JeeoI%2fAAAAAAAATFY%2fWdA9CxrUkLw%2fs16000%2f0000-002.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-mOI1JczWk3I%2fVkHMY45Z90I%2fAAAAAAAAUvA%2fV8JrAh-vJ4M%2fs16000%2f0000-003.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-3HJxBsoOXn4%2fVkHGXEyBFVI%2fAAAAAAAATX4%2foLw45h0eTck%2fs16000%2f0000-004.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-5JRuFlKb6EY%2fVkHLYdGRwbI%2fAAAAAAAAUgc%2fctctFd_kcoo%2fs16000%2f0000-005.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-Z14_efUrUHU%2fVkHCTtjZquI%2fAAAAAAAASVc%2fmofU30I2d-w%2fs16000%2f0000-006.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-ly9LCITWSbo%2fVkHMtP_CHTI%2fAAAAAAAAU1k%2fHvfv5aGp-pE%2fs16000%2f0000-007.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-wswgqa8aL7A%2fVkHEIPdCMzI%2fAAAAAAAASvI%2fOlrK0jL4MXA%2fs16000%2f0000-008.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-ECYGvJNuXxI%2fVkHBUkfzI0I%2fAAAAAAAASD8%2fFunpyZ73PZo%2fs16000%2f0000-009.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-gCOQnlxHnmE%2fVkHBrhd0lZI%2fAAAAAAAASI0%2fiYhe7nyiBSE%2fs16000%2f0000-010.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-BsSQvkrgJ5A%2fVkHNRXfjyPI%2fAAAAAAAAU9I%2fkcYUwLgEH9o%2fs16000%2f0000-011.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-3LxU1FpJEM8%2fVkHEvGYO9gI%2fAAAAAAAAS5I%2f5N9YUR1IKIc%2fs16000%2f0000-012.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-0GQmnm8_Cpg%2fVkHIZXd2fbI%2fAAAAAAAATxs%2fdVDxgdSn88g%2fs16000%2f0000-013.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-ng2WcgmadVk%2fVkHFqpuIBqI%2fAAAAAAAATHo%2fU6PYs6jxi5I%2fs16000%2f0000-014.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-BU-OeBtqX-E%2fVkHPGOEuuLI%2fAAAAAAAAVac%2ffccUusNtJz0%2fs16000%2f0000-015.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-OBpFltQ66nE%2fVkHJhQ_A89I%2fAAAAAAAAUDQ%2fy-pR66apjdc%2fs16000%2f0000-016.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-556Udct0lKE%2fVkHN_tMxjzI%2fAAAAAAAAVIk%2fg3-y07spBHk%2fs16000%2f0000-017.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-5DbaXPrA77w%2fVkHDSTsMnAI%2fAAAAAAAASho%2fl9QcFlBPDfQ%2fs16000%2f0000-018.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-DXZZisvbox4%2fVkHEhSyeXPI%2fAAAAAAAAS8A%2fVIwwkEZWQ2Y%2fs16000%2f0000-019.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-Uo87LIGNMoU%2fVkHH7EOdOfI%2fAAAAAAAATqY%2fr-EXuqHtQ20%2fs16000%2f0000-020.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-hXQTWTiJvPA%2fVkHAYjOMWOI%2fAAAAAAAARzo%2f6cOvdVXwoiI%2fs16000%2f0000-021.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-rXIpmg-C9_s%2fVkHKSXZNiYI%2fAAAAAAAAUPI%2f_06LbEvt3B8%2fs16000%2f0000-022.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-D3CbOki8_2o%2fVkHO4qUerBI%2fAAAAAAAAVYQ%2fnxchshFyEJM%2fs16000%2f0000-023.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-rNR2UcMHcgY%2fVkHBJ62R0fI%2fAAAAAAAAR_0%2fcPGI0p9RtFM%2fs16000%2f0000-024.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-ZnFxepVGiTI%2fVkHDNnwBEzI%2fAAAAAAAASgk%2fxfulsV2QnNs%2fs16000%2f0000-025.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-xe6AdJA3FsM%2fVkHPh8qqSAI%2fAAAAAAAAVhw%2fcj1vwwlxMdI%2fs16000%2f0000-026.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-9_MRKMGWfKE%2fVkHKTTObDuI%2fAAAAAAAAUPY%2fH3Nm4KBy5VI%2fs16000%2f0000-027.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-5Iwi30nQcbU%2fVkHGZDVZZ9I%2fAAAAAAAATTU%2fnPD9AVP7ISA%2fs16000%2f0000-028.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-Ese7QrB7Ic8%2fVkHLnOSzvyI%2fAAAAAAAAUkQ%2f8ISCWu63t2k%2fs16000%2f0000-029.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-TUuXmjg5Gvs%2fVkHOVIPKzfI%2fAAAAAAAAVOo%2fAzJlt7W3Mwg%2fs16000%2f0000-030.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-iJaeMbWv-NM%2fVkHHjWM6oWI%2fAAAAAAAATkc%2f4jCigD5J9JI%2fs16000%2f0000-031.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-tEF1ZX2dFGA%2fVkHGeI-vzdI%2fAAAAAAAATUE%2fV_ibVtiEuTk%2fs16000%2f0000-032.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-ynuk9htNRWY%2fVkHEyOt5pzI%2fAAAAAAAAS6A%2fsKIxyHA79jM%2fs16000%2f0000-033.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-rZQE-B6Kd0k%2fVkHPa5-V4YI%2fAAAAAAAAVg4%2fOMci4lyhj6I%2fs16000%2f0000-034.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-cz7UAxCJ8ew%2fVkHHVPPfKQI%2fAAAAAAAAThI%2frtYpyvsGqQk%2fs16000%2f0000-035.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-3_dB6OcPQqg%2fVkHATq2P0XI%2fAAAAAAAARyU%2fZgqQNy7m6Hs%2fs16000%2f0000-036.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-Y8yWNpizeXQ%2fVkHEo15SV9I%2fAAAAAAAAS3w%2f06jCtlR4mJI%2fs16000%2f0000-037.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-DRST9WJSYGs%2fVkHHYSYXjVI%2fAAAAAAAATiI%2fAbDRL902r3g%2fs16000%2f0000-038.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-yj4a9yT1rzA%2fVkHHYF9Of2I%2fAAAAAAAATh8%2fzhg1K-LD_Og%2fs16000%2f0000-039.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-7sKuR5UYGSM%2fVkHBakbTVVI%2fAAAAAAAASEE%2fbl7Zs3yDy9U%2fs16000%2f0000-040.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-z7Hvyxa-mSM%2fVkHApzmUR7I%2fAAAAAAAAR4Q%2fs2dhzDMbdA0%2fs16000%2f0000-041.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-KMa9tdx6U30%2fVkHAfs6GV7I%2fAAAAAAAAR1k%2f8aLRGpTh8Sw%2fs16000%2f0000-042.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-XDcjf-bBwgY%2fVkHDI6gh8kI%2fAAAAAAAASow%2fEA2lx_bOP7o%2fs16000%2f0000-043.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-s636erb2pz0%2fVkHNt6W5MkI%2fAAAAAAAAVQM%2f6q0UESPG4Fk%2fs16000%2f0000-044.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-23oyhg-466s%2fVkHFXKiN9GI%2fAAAAAAAATC8%2f94HiSNqKdt0%2fs16000%2f0000-045.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-s7m4dtOBxw4%2fVkHPIrpv-BI%2fAAAAAAAAVbI%2fhYU6OSrAMKM%2fs16000%2f0000-046.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-wSAG8lhdm9M%2fVkHPuH-PGFI%2fAAAAAAAAVkw%2fFSLxnKhh2mQ%2fs16000%2f0000-047.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-TvsEU1bMnGs%2fVkHBgTmAouI%2fAAAAAAAASFs%2fgE5cEi4kr-w%2fs16000%2f0000-048.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-U7wA3v3uPL4%2fVkHHDL12N7I%2fAAAAAAAATcg%2fCgEkFvRDjwU%2fs16000%2f0000-049.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-safx7Q7vGXw%2fVkHFv1g1EjI%2fAAAAAAAATKU%2fBpkDWuZHScI%2fs16000%2f0000-050.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-16xPym1JsR4%2fVkHCX2zTxaI%2fAAAAAAAASTc%2fk8nkgFlNTQs%2fs16000%2f0000-051.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-Lqq5uHZfskA%2fVkHD_QZyOII%2fAAAAAAAAStA%2fRB6cNmO9CXk%2fs16000%2f0000-052.jpg&imgmax=30000","https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&gadget=a&no_expand=1&resize_h=0&rewriteMime=image%2F*&url=http%3a%2f%2f2.bp.blogspot.com%2f-3k9FeyDzC5E%2fVkHEp-DoZJI%2fAAAAAAAAS5s%2fGOq5qeX-Edk%2fs16000%2f0000-053.jpg&imgmax=30000"   
    ]
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collection.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.link = images[indexPath.row]
        ImageController.download(self, url: URL(string:images[indexPath.row])!,action: {
            (image) in
            if (image != nil)
            {
                cell.image.image = image
                cell.ind.stopAnimating()
            }
            
        
        })//, acc: { print($0)})
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let padd  = sectionInsets.left
        let avW = view.frame.width - 20
        let avH = view.frame.height - 60
        let width = avW/2
        let height = avH/2
        return CGSize(width: width, height: height)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }


}

