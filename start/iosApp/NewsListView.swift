import SwiftUI

struct NewsListView: View{
    @ObservedObject var model = NewsListModel()
    
    var body: some View {
        NavigationView {
            List(model.items) { item in
                NavigationLink(destination: NewsItemView(newsItem: item)) {
                    NewsItemRow(item: item)
                }
            }.onAppear{
                model.loadNewsMoya()//loadFromAlamofire()//loadNewsAsync()//.loadNews()
            }.navigationBarTitle("News", displayMode: .inline)
        }
    }
}
