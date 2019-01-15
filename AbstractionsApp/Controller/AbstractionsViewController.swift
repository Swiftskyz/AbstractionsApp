import UIKit

public class AbstractionsViewController: UIViewController, UIPageViewControllerDataSource
{
    //MARK:- Data Members
    private lazy var orderedAbstractionViews : [UIViewController] =
    {
        return [
            self.newAbstractionsViewController(abstractionLevel: "Swift"),
            self.newAbstractionsViewController(abstractionLevel: "Block"),
            self.newAbstractionsViewController(abstractionLevel: "ByteCode"),
            self.newAbstractionsViewController(abstractionLevel: "Binary"),
            self.newAbstractionsViewController(abstractionLevel: "LogicalGate")
        ]
    }( )
    //MAARK: Helper method to retrieve the correct ViewController based on the data member
    private func newAbstractionsViewController(abstractionLevel : String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(abstractionLevel)ViewController")
    }
    //MARK:- Lifecycle methods
    public override func viewDidLoad( )
    {
        super.viewDidLoad( )
        dataSource = self
        
        if let firstViewController = orderedAbstractionViews.first
        {
            setViewControllers([firstViewController],
                                            direction: .forward,
                                            animated: true,
                                            completion: nil)
        }

}
    //MARK:- Datasource required methods
    /// Swipe Left
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = orderedAbstractionViews.index(of: viewController)
            else
        {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0
            else
        {
            return orderedAbstractionViews.last
        }
        
        guard orderedAbstractionViews.count > previousIndex
            else
        {
            return nil
        }
        
        return orderedAbstractionViews[previousIndex]
    }
    //Swipe right
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = orderedAbstractionViews.index(of: viewController)
            else
        {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex >= 0
            else
        {
            return nil
        }
        
        guard nextIndex < orderedAbstractionViews.count
            else
        {
            return orderedAbstractionViews.first
        }
        
        return orderedAbstractionViews[nextIndex]
    }
    //MARK:- Optional Support for the dots in the UIPageViewController
    public func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
        return orderedAbstractionViews.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int
    {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = orderedAbstractionViews.index(of: firstViewController)
            else
        {
            return 0
        }
        
        return firstViewControllerIndex
    }

}



