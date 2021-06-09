//
//  AspectVGrid.swift
//  Flip
//
//  Created by WeIHa'S on 2021/6/8.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRadio: CGFloat
    var content: (Item) -> ItemView
    
    
    init(items: [Item], aspectRadio: CGFloat, @ViewBuilder content: @escaping (Item)-> ItemView) {
        self.items = items
        self.aspectRadio = aspectRadio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRadio)
                
                LazyVGrid(columns: [adptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRadio, contentMode: .fit)
                    }
                }
            }
            Spacer(minLength: 0)
        }
        
    }
    
    
    
    
    private func adptiveGridItem(width: CGFloat) -> GridItem{
        var griditem = GridItem(.adaptive(minimum: width))
        griditem.spacing = 0
        return griditem
    }
    
    
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat{
        var columnCount = 1
        var rowCount = itemCount
        
        repeat{
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1 )) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
    
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
